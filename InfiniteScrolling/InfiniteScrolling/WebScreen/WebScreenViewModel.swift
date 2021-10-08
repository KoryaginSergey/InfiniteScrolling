//
//  WebScreenViewModel.swift
//  InfiniteScrolling
//
//  Created by macuser on 08.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine


protocol WebScreenViewModelProtocol: AnyObject {
  var viewState: AnyPublisher<WebScreen.Models.ViewState, Never> { get }
  var viewAction: AnyPublisher<WebScreen.Models.ViewAction, Never> { get }
  var route: AnyPublisher<WebScreen.Models.ViewRoute, Never> { get }
  
  func process(input: WebScreen.Models.ViewModelInput)
}

final class WebScreenViewModel {
  
  // MARK: - Properties
  
  //    @Injected(container: .shared)
  //    private var hapticService: HapticFeedbackServiceProtocol
  
  private let viewStateSubj = CurrentValueSubject<WebScreen.Models.ViewState, Never>(.idle)
  private let viewActionSubj = PassthroughSubject<WebScreen.Models.ViewAction, Never>()
  private let routeSubj = PassthroughSubject<WebScreen.Models.ViewRoute, Never>()
  
  private var subscriptions = Set<AnyCancellable>()
}

// MARK: - WebScreenViewModelProtocol

extension WebScreenViewModel: WebScreenViewModelProtocol {
  
  var viewState: AnyPublisher<WebScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
  var viewAction: AnyPublisher<WebScreen.Models.ViewAction, Never> { viewActionSubj.eraseToAnyPublisher() }
  var route: AnyPublisher<WebScreen.Models.ViewRoute, Never> { routeSubj.eraseToAnyPublisher() }
  
  func process(input: WebScreen.Models.ViewModelInput) {
    //        input.onLoad.sink { [weak self] _ in
    //            self?.fetch()
    //        }.store(in: &subscriptions)
  }
}

// MARK: - Private

private extension WebScreenViewModel {
  //    func fetch() {
  //        viewStateSubj.send(.loading)
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
  //    }
}
