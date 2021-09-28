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
  var viewAction: AnyPublisher<MainScreen.Models.ViewAction, Never> { get }
  var route: AnyPublisher<MainScreen.Models.ViewRoute, Never> { get }
  
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
  func fetch() {
    viewStateSubj.send(.loading)
    
    viewStateSubj.send(.loaded(sections: [
      .init(items: [
        .topItem(state: .init(titleViewState: .init(title: "Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORTS", date: "March 12, 2019"), image: UIImage(named: "sport"))),
        .topItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "GAMES", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
        .topItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "POLITICS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
        .topItem(state: .init(titleViewState: .init(title: "Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "BUSINESS", date: "March 12, 2019"), image: UIImage(named: "qovery")))
      ]),
      .init(items: [
        .bottomItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "POLITICS", date: "March 12, 2019"), image: UIImage(named: "qovery"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Cowboys to defeat of Philadelphia Eagles on MNF", source: "BUSINESS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Dak Prescott, Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "swanTeam"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "qovery"))),
        .bottomItem(state: .init(titleViewState: .init(title: "MNF - USA TODAY", source: "BUSINESS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "swanTeam"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "qovery"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "POLITICS", date: "March 12, 2019"), image: UIImage(named: "politic"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "GAMES", date: "March 12, 2019"), image: UIImage(named: "nintendo"))),
        .bottomItem(state: .init(titleViewState: .init(title: "Dak Prescott, Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "swanTeam")))
      ])
    ]))
    
    
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
