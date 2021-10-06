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
  
  func process(input: MainScreen.Models.ViewModelInput)
}

final class MainScreenViewModel {
  
  // MARK: - Properties
  //    @Injected(container: .shared)
  //    private var hapticService: HapticFeedbackServiceProtocol
  
  ///
  
  private let viewStateSubj = CurrentValueSubject<MainScreen.Models.ViewState, Never>(.idle)
  private let viewActionSubj = PassthroughSubject<MainScreen.Models.ViewAction, Never>()
  private let routeSubj = PassthroughSubject<MainScreen.Models.ViewRoute, Never>()
  
  private var subscriptions = Set<AnyCancellable>()
 
  var page = Page(size: 10, page: 1)
  
  private var topItems:[Article] = []
  private var bottomItems:[Article] = []
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
  
  func setImage(urlToImage: URL) -> UIImageView {
    var image: UIImageView?
    image?.sd_setImage(with: urlToImage, placeholderImage: UIImage(named: "sport"))
    return image!
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
        
      print(data)
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
//        let image = UIImage()
//        return .topItem(state: .init(titleViewState: .init(title: article.title ?? "", source: article.source?.name ?? "", date: article.publishedAt ?? ""), image: setImage(urlToImage: article.urlToImage!)))
//      })
      
      return .topItem(state: .init(titleViewState: .init(title: article.title ?? "", source: article.source?.name ?? "", date: article.publishedAt ?? ""), image: UIImage(named: "sport")))
    })
      let itemsBottom = self?.bottomItems.map({ (article) -> MainScreen.Models.Item in
        return .bottomItem(state: .init(titleViewState: .init(title: article.title ?? "", source: article.source?.name ?? "", date: article.publishedAt ?? ""), image: UIImage(named: "sport")))
      })
      
      self?.viewStateSubj.send(.loaded(sections: [.init(items: itemsTop ?? []),
                                                  .init(items: itemsBottom ?? []) ]))
    }
    
//    viewStateSubj.send(.loaded(sections: [
//      .init(items: [
//        .topItem(state: .init(titleViewState: .init(title: "Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORTS", date: "March 12, 2019"), image: UIImage(named: "sport"))),
//        .topItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "GAMES", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
//        .topItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "POLITICS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
//        .topItem(state: .init(titleViewState: .init(title: "Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "BUSINESS", date: "March 12, 2019"), image: UIImage(named: "qovery")))
//      ]),
//      .init(items: [
//        .bottomItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "POLITICS", date: "March 12, 2019"), image: UIImage(named: "qovery"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Cowboys to defeat of Philadelphia Eagles on MNF", source: "BUSINESS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Dak Prescott, Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "swanTeam"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "qovery"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "MNF - USA TODAY", source: "BUSINESS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "swanTeam"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "qovery"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "POLITICS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "GAMES", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
//        .bottomItem(state: .init(titleViewState: .init(title: "Dak Prescott, Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "swanTeam")))
//      ])
//    ]))
    
    
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
