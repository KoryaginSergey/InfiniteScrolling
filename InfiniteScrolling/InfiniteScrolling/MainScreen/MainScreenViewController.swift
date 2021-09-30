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
    
    viewModel?.route
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] route in
        self?.handleRoute(route)
      }).store(in: &subscriptions)
    
    viewModel?.viewAction
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] action in
        self?.handleAction(action)
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
      collectionView.reloadData()
    //            stopLoading()
    case .empty:
      stopLoading()
    case .failure:
      stopLoading()
    }
  }
  
  func handleAction(_ action: MainScreen.Models.ViewAction) {
    switch action {
    //show alert
    //scrollToTop
    // ...
    }
  }
  
  func handleRoute(_ route: MainScreen.Models.ViewRoute) {
    switch route {
    case .dismiss:
      break
    //          dismiss(animated: true, completion: nil)
    }
  }
}

// MARK: - DataSourc
private extension MainScreenViewController {
  
  func updateSnapshot(_ sections: [MainScreen.Models.Section], animated: Bool = true) {
    dataSource.updateSnapshot(sections, animated: animated)
  }
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

extension MainScreenViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = dataSource.getItem(indexPath: indexPath)

    var snapshot: MainScreen.Models.State?
    switch item {
    case let .topItem(state: state):
      snapshot = state
    case let .bottomItem(state: state):
      snapshot = state
    default:
      break
    }
    
    present(DetailsScreen.Assembly.createModule(with: DetailsScreenViewModel(state: snapshot)), animated: true, completion: nil)
  }
}
