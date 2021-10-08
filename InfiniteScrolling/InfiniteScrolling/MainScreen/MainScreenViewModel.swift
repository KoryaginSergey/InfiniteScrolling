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
import SDWebImage


protocol MainScreenViewModelProtocol: AnyObject {
  var viewState: AnyPublisher<MainScreen.Models.ViewState, Never> { get }
  var viewAction: AnyPublisher<MainScreen.Models.ViewAction, Never> { get }
  var route: AnyPublisher<MainScreen.Models.ViewRoute, Never> { get }
  
  var topItems:[Article] { get }
  var bottomItems:[Article] { get }
  
  func process(input: MainScreen.Models.ViewModelInput)
}

final class MainScreenViewModel {
  
  // MARK: - Properties
  //    @Injected(container: .shared)
  //    private var hapticService: HapticFeedbackServiceProtocol
  
  private let viewStateSubj = CurrentValueSubject<MainScreen.Models.ViewState, Never>(.idle)
  private let viewActionSubj = PassthroughSubject<MainScreen.Models.ViewAction, Never>()
  private let routeSubj = PassthroughSubject<MainScreen.Models.ViewRoute, Never>()
  
  private var subscriptions = Set<AnyCancellable>()
  
  var page = Page(size: 10, page: 1)
  
  var topItems:[Article] = []
  var bottomItems:[Article] = []
}

// MARK: - MainScreenViewModelProtocol
extension MainScreenViewModel: MainScreenViewModelProtocol {
  
  var viewState: AnyPublisher<MainScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
  var viewAction: AnyPublisher<MainScreen.Models.ViewAction, Never> { viewActionSubj.eraseToAnyPublisher() }
  var route: AnyPublisher<MainScreen.Models.ViewRoute, Never> { routeSubj.eraseToAnyPublisher() }
  
  func process(input: MainScreen.Models.ViewModelInput) {
    input.onLoad.sink { [weak self] _ in
      self?.fetch()
    }.store(in: &subscriptions)
  }
}

// MARK: - Private
private extension MainScreenViewModel {
  
  func convertToDate(from originalDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = dateFormatter.date(from: originalDate)
    dateFormatter.dateFormat = "MMM dd, yyyy"
    let valueDate = dateFormatter.string(from: date!)
    return valueDate
  }
  
  func fetch() {
    viewStateSubj.send(.loading)
    
    let group = DispatchGroup()
    
    group.enter()
    PostServices.shared.getTopPosts(page: page) { [weak self] (result) in
      switch result {
      case let .success(data):
        guard let articles = data.articles else {
          return
        }
        self?.topItems = articles
      case let .failure(error):
        print(error)
      }
      group.leave()
    }
    group.enter()
    PostServices.shared.getBottomPosts(page: page) { [weak self] (result) in
      switch result {
      case let .success(data):
        guard let articles = data.articles else {
          return
        }
        self?.bottomItems = articles
      case let .failure(error):
        print(error)
      }
      group.leave()
    }
    
    group.notify(queue: DispatchQueue.main) { [weak self] in
      let itemsTop = self?.topItems.map({ (article) -> MainScreen.Models.Item in
//        guard let articleTitle = article.title,
//              let articleSourceName = article.source?.name,
//              let articlePublishedAt = article.publishedAt else {return}
        return .topItem(state: .init(titleViewState: .init(title: article.title ?? "", source: article.source?.name ?? "", date: self!.convertToDate(from: article.publishedAt!)), imageURL: article.urlToImage ?? URL(string: "news1")))
      })
      let itemsBottom = self?.bottomItems.map({ (article) -> MainScreen.Models.Item in
        return .bottomItem(state: .init(titleViewState: .init(title: article.title ?? "", source: article.source?.name ?? "", date: self!.convertToDate(from: article.publishedAt!)), imageURL: article.urlToImage ?? URL(string: "news1")))
      })
      
      self?.viewStateSubj.send(.loaded(sections: [.init(items: itemsTop ?? []),
                                                  .init(items: itemsBottom ?? []) ]))
    }
    
    //        service.fetch.sink { [weak self] result in
    //            guard let self = self else { return }
    //            switch result {
    //            case .success([]):
    //                self.viewStateSubj.send(.empty)
    //            case let .success(items):
    //                self.viewStateSubj.send(.loaded(items)
    //            case let .failure(error):
    //                self.viewStateSubj.send(.failure(error)
    //            }
    //        }.store(in: &subscriptions)
  }
}
