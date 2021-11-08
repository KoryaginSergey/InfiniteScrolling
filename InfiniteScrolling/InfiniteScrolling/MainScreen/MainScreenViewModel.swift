//
//  MainScreenViewModel.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine
import UIKit


protocol MainScreenViewModelProtocol: AnyObject {
  var viewState: AnyPublisher<MainScreen.Models.ViewState, Never> { get }
  
  var topItems:[Article] { get }
  var bottomItems:[Article] { get }
  
  func process(input: MainScreen.Models.ViewModelInput)
  func retrieveNewData(at indexPath: IndexPath)
}

final class MainScreenViewModel {
  
  // MARK: - Properties
  private let viewStateSubj = CurrentValueSubject<MainScreen.Models.ViewState, Never>(.idle)
  private var subscriptions = Set<AnyCancellable>()
  
  var topPage = Page(size: 10, page: 1)
  var bottomPage = Page(size: 10, page: 1)
  
  var isTopLoading: Bool = false
  var isBottomLoading: Bool = false
  
  var topItems:[Article] = []
  var bottomItems:[Article] = []
}

// MARK: - MainScreenViewModelProtocol
extension MainScreenViewModel: MainScreenViewModelProtocol {
  var viewState: AnyPublisher<MainScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
  
  func process(input: MainScreen.Models.ViewModelInput) {
    input.onLoad.sink { [weak self] _ in
      self?.fetch()
    }.store(in: &subscriptions)
  }
}

extension MainScreenViewModel {
  func retrieveNewData(at indexPath:IndexPath) {
    switch indexPath.section {
    case 0:
      if isTopLoading { return }
      if indexPath.row == self.topItems.count - 1 {
        if self.topPage.isFull { return }
        self.isTopLoading = true
        self.fetchTopItems { [weak self] in
          self?.isTopLoading = false
        }
      }
    case 1:
      if isBottomLoading { return }
      if indexPath.row == self.bottomItems.count - 1 {
        if self.bottomPage.isFull { return }
        self.isBottomLoading = true
        self.fetchBottomItems { [weak self] in
          self?.isBottomLoading = false
        }
      }
    default: break
    }
  }
}

// MARK: - Private
private extension MainScreenViewModel {
  func fetch() {
    let group = DispatchGroup()
    group.enter()
    self.fetchTopItems {
      group.leave()
    }
    group.enter()
    self.fetchBottomItems {
      group.leave()
    }
    
    group.notify(queue: DispatchQueue.main) { [weak self] in
      self?.reloadData()
    }
  }
  
  func reloadData() {
    let itemsTop = self.topItems.map({ (article) -> MainScreen.Models.Item in
      return .topItem(state: .init(titleViewState: .init(title: article.title, source: article.source?.name, date: article.publishedAt?.mmm_dd_yyyy()), imageURL: article.urlToImage))
    })
    let itemsBottom = self.bottomItems.map({ (article) -> MainScreen.Models.Item in
      return .bottomItem(state: .init(titleViewState: .init(title: article.title, source: article.source?.name, date: article.publishedAt?.mmm_dd_yyyy()), imageURL: article.urlToImage))
    })
    self.viewStateSubj.send(.loaded(sections: [.init(id: 0, items: itemsTop),
                                               .init(id: 1, items: itemsBottom) ]))
  }
  
  func fetchTopItems(closure: (()->Void)?) {
    PostServices.shared.getTopPosts(page: topPage) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case let .success(data):
        guard let articles = data.articles else { return }
        
        
//        self.topItems += articles
//        self.reloadData()
        self.topPage.page = self.topPage.page + 1
        self.topPage.isFull = data.totalResults == self.topItems.count
      case let .failure(error):
        print(error)
      }
      closure?()
    }
  }
  
  func fetchBottomItems(closure: (()->Void)?) {
    PostServices.shared.getBottomPosts(page: bottomPage) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case let .success(data):
        guard let articles = data.articles else { return }
//        self.bottomItems += articles
//        self.reloadData()
        self.bottomPage.page = self.bottomPage.page + 1
        self.bottomPage.isFull = data.totalResults == self.bottomItems.count
      case let .failure(error):
        print(error)
      }
      closure?()
    }
  }
}

extension Array 


