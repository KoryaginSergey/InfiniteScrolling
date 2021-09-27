//
//  MainScreenViewModel.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

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
    
    
    viewStateSubj.send(.loaded(items: [
      .topItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil)),
      .topItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil)),
      .topItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil)),
      .topItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil))
    ]))
    
//    viewStateSubj.send(.loaded(items: [
//      .bottomItem(state: .init(titleViewState: .init(title: "title", source: "source", date: "date"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "привет", source: "test", date: "test"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "title", source: "source", date: "date"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "привет", source: "test", date: "test"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "title", source: "source", date: "date"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "привет", source: "test", date: "test"), image: nil)),
//      .bottomItem(state: .init(titleViewState: .init(title: "test", source: "test", date: "test"), image: nil))
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
