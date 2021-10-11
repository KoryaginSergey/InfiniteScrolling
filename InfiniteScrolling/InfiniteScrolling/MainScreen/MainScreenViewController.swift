//
//  MainScreenViewController.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import Combine


final class MainScreenViewController: UIViewController, StoryboardBased {
  
  // MARK: - Properties
  
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var titleLabel: UILabel!
  
  private lazy var dataSource = MainScreenDataSource(collectionView: collectionView)
  private var viewModel: MainScreenViewModelProtocol?
  private let onLoad = PassthroughSubject<Void, Never>()
  public var subscriptions = Set<AnyCancellable>()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind(to: viewModel)
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
      updateSnapshot([], animated: false)
    case .loading:
      startLoading()
    case .loaded(sections: let section):
      self.updateSnapshot(section)
    case .empty:
      stopLoading()
    case .failure:
      stopLoading()
    }
  }
}

// MARK: - DataSource

private extension MainScreenViewController {
  
  func updateSnapshot(_ sections: [MainScreen.Models.Section], animated: Bool = true) {
    dataSource.updateSnapshot(sections, animated: animated)
  }
}

// MARK: - Delegate

extension MainScreenViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    viewModel?.retrieveNewData(at: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var article: Article?
    switch indexPath.section {
    case 0:
      article = viewModel?.topItems[indexPath.row]
    case 1:
      article = viewModel?.bottomItems[indexPath.row]
    default:
      break
    }
    
    present(DetailsScreen.Assembly.createModule(with: DetailsScreenViewModel(article: article!)), animated: true, completion: nil)  }
}

// MARK: - Private

private extension MainScreenViewController {
  
  func setup() {
  }
  
  func startLoading() {
  }
  
  func stopLoading() {
  }
}


