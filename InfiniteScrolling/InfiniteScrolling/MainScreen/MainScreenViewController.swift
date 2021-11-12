//
//  MainScreenViewController.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import Combine
import CoreData


final class MainScreenViewController: UIViewController, StoryboardBased {
  
  // MARK: - Properties
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var titleLabel: UILabel!
  
  private lazy var dataSource = MainScreenDataSource(collectionView: collectionView)
  private var viewModel: MainScreenViewModelProtocol?
  private let onLoad = PassthroughSubject<Void, Never>()
  public var subscriptions = Set<AnyCancellable>()
  
  let fetchedResultsController: NSFetchedResultsController<CDModelArticle> = {
    let request: NSFetchRequest<CDModelArticle> = CDModelArticle.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
    let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DataModels.sharedInstance.context, sectionNameKeyPath: "type", cacheName: nil)
    return controller
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bind(to: viewModel)
    
    self.fetchedResultsController.delegate = self
    do {
      try self.fetchedResultsController.performFetch()
    } catch {
      print("")
    }
    
    onLoad.send(())
    collectionView.delegate = self
  }
}

// MARK: - Internal methods
extension MainScreenViewController {
  func setDependencies(viewModel: MainScreenViewModelProtocol) {
    self.viewModel = viewModel
  }
}

// MARK: - Bind
private extension MainScreenViewController {
  func bind(to viewModel: MainScreenViewModelProtocol?) {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
    let input = MainScreen.Models.ViewModelInput(onLoad: onLoad.eraseToAnyPublisher())
    viewModel?.process(input: input)
    viewModel?.viewState
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] state in
        self?.render(state)
      }).store(in: &subscriptions)
  }
  
  func render(_ state: MainScreen.Models.ViewState) {
    switch state {
    case .idle:
      break
    case .loaded(sections: _):
      break
    }
  }
}

// MARK: - DataSource
private extension MainScreenViewController {
}

// MARK: - Delegate
extension MainScreenViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let objects = fetchedResultsController.sections?[indexPath.section].objects as? [CDModelArticle] else { return }
    if indexPath.row == objects.count - 1 {
      viewModel?.retrieveNewData(at: indexPath)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let article = fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row] as? CDModelArticle else { return }
    
    if article.content != nil {
      present(DetailsScreen.Assembly.createModule(with: DetailsScreenViewModel(article: article)), animated: true, completion: nil)
    } else {
      present(WebScreen.Assembly.createModule(with: WebScreenViewModel(modelArticle: article)), animated: true, completion: nil)
    }
  }
}

extension MainScreenViewController: NSFetchedResultsControllerDelegate {
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    let snapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
    var mySnapshot = MainScreenDataSource.Snapshot()
    mySnapshot.appendSections(snapshot.sectionIdentifiers)
    
    mySnapshot.sectionIdentifiers.forEach { section in
      let itemIdentifiers = snapshot.itemIdentifiers(inSection: section)
        .map {DataModels.sharedInstance.context.object(with: $0) as! CDModelArticle}
        .map { article -> MainScreen.Models.Item in
          if section == "0" {
            return .topItem(state: .init(id: article.id, titleViewState: .init(title: article.title, source: article.nameSource, date: article.publishedAt?.mmm_dd_yyyy()), imageURL: article.urlToImage))
          }
          return .bottomItem(state: .init(id: article.id, titleViewState: .init(title: article.title, source: article.nameSource, date: article.publishedAt?.mmm_dd_yyyy()), imageURL: article.urlToImage))
        }
      mySnapshot.appendItems(itemIdentifiers, toSection: section)
    }
    if mySnapshot.sectionIdentifiers.count == 2 {
      self.dataSource.updateSnapshot(mySnapshot)
    }
  }
}


