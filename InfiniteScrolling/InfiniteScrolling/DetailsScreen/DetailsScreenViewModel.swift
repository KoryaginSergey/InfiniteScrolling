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
  
  func process(input: DetailsScreen.Models.ViewModelInput)
}

final class DetailsScreenViewModel {
  
// MARK: - Properties
  
  var article: Article
  private let viewStateSubj = CurrentValueSubject<DetailsScreen.Models.ViewState, Never>(.idle)
  private var subscriptions = Set<AnyCancellable>()
  
  init(article: Article) {
    self.article = article
  }
}

// MARK: - DetailsScreenViewModelProtocol

extension DetailsScreenViewModel: DetailsScreenViewModelProtocol {
  
  var viewState: AnyPublisher<DetailsScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
  
  func process(input: DetailsScreen.Models.ViewModelInput) {
    input.onLoad.sink { [weak self] _ in
      self?.fetch()
    }.store(in: &subscriptions)
  }
}

// MARK: - Private

private extension DetailsScreenViewModel {
  
  func fetch() {
    let titleViewState = TitleView.State(title: article.title, source: article.source?.name, date: article.publishedAt?.mmmm_dd_yyyy())
    let state = DetailsScreen.Models.State(titleViewState: titleViewState, imageURL: article.urlToImage, content: article.content)
    self.viewStateSubj.send(.loaded(state: state))
  }
}
