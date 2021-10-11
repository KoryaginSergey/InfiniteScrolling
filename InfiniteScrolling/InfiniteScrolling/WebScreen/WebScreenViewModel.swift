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
  func process(input: WebScreen.Models.ViewModelInput)
}

final class WebScreenViewModel {
  
  // MARK: - Properties
  
  var modelArticle: Article
  
  private let viewStateSubj = CurrentValueSubject<WebScreen.Models.ViewState, Never>(.idle)
  private var subscriptions = Set<AnyCancellable>()
  
  init(modelArticle: Article) {
    self.modelArticle = modelArticle
  }
}

// MARK: - WebScreenViewModelProtocol

extension WebScreenViewModel: WebScreenViewModelProtocol {
  var viewState: AnyPublisher<WebScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
  
  func process(input: WebScreen.Models.ViewModelInput) {
    input.onLoad.sink { [weak self] _ in
      self?.fetch()
    }.store(in: &subscriptions)
  }
}

// MARK: - Private

private extension WebScreenViewModel {
  func fetch() {
    let state = WebScreen.Models.State(urlAddress: modelArticle.url)
    viewStateSubj.send(.loaded(state: state))
  }
}
