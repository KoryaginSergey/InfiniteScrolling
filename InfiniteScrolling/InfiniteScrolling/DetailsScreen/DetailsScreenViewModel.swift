//
//  DetailsScreenViewModel.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol DetailsScreenViewModelProtocol: AnyObject {
    var viewState: AnyPublisher<DetailsScreen.Models.ViewState, Never> { get }
    var viewAction: AnyPublisher<DetailsScreen.Models.ViewAction, Never> { get }
    var route: AnyPublisher<DetailsScreen.Models.ViewRoute, Never> { get }

    func process(input: DetailsScreen.Models.ViewModelInput)
}

final class DetailsScreenViewModel {
    
    // MARK: - Properties
    var state: MainScreen.Models.State?
  
    private let viewStateSubj = CurrentValueSubject<DetailsScreen.Models.ViewState, Never>(.idle)
    private let viewActionSubj = PassthroughSubject<DetailsScreen.Models.ViewAction, Never>()
    private let routeSubj = PassthroughSubject<DetailsScreen.Models.ViewRoute, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
  
  init(state: MainScreen.Models.State? = nil) {
    self.state = state
  }
}

// MARK: - DetailsScreenViewModelProtocol
extension DetailsScreenViewModel: DetailsScreenViewModelProtocol {

    var viewState: AnyPublisher<DetailsScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
    var viewAction: AnyPublisher<DetailsScreen.Models.ViewAction, Never> { viewActionSubj.eraseToAnyPublisher() }
    var route: AnyPublisher<DetailsScreen.Models.ViewRoute, Never> { routeSubj.eraseToAnyPublisher() }
    
    func process(input: DetailsScreen.Models.ViewModelInput) {
        input.onLoad.sink { [weak self] _ in
//            self?.fetch()
          self?.viewStateSubj.send(.loaded(item: .init(titleViewState: .init(title: "Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY", source: "SPORT", date: "March 12, 2019"), image: UIImage(named: "sport"), content: "Ezekiel Elliott, Trevon Diggs lead Dallas Cowboys to defeat of Philadelphia Eagles on MNF - USA TODAY")))
//          viewStateSubj.send(.loaded(item: .init(item: .init(titleViewState: .init(title: "hi", source: "hi", date: "hi"), image: UIImage(named: "sport"), content: "ggggggg"))))
          //вызвать loaded со структурой
        }.store(in: &subscriptions)
    }
}

// MARK: - Private
private extension DetailsScreenViewModel {
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
