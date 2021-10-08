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
  var article: Article
  
  private let viewStateSubj = CurrentValueSubject<DetailsScreen.Models.ViewState, Never>(.idle)
  private let viewActionSubj = PassthroughSubject<DetailsScreen.Models.ViewAction, Never>()
  private let routeSubj = PassthroughSubject<DetailsScreen.Models.ViewRoute, Never>()
  
  private var subscriptions = Set<AnyCancellable>()
  
  init(article: Article) {
    self.article = article
  }
}

// MARK: - DetailsScreenViewModelProtocol
extension DetailsScreenViewModel: DetailsScreenViewModelProtocol {
  
  var viewState: AnyPublisher<DetailsScreen.Models.ViewState, Never> { viewStateSubj.eraseToAnyPublisher() }
  var viewAction: AnyPublisher<DetailsScreen.Models.ViewAction, Never> { viewActionSubj.eraseToAnyPublisher() }
  var route: AnyPublisher<DetailsScreen.Models.ViewRoute, Never> { routeSubj.eraseToAnyPublisher() }
  
  func process(input: DetailsScreen.Models.ViewModelInput) {
    input.onLoad.sink { [weak self] _ in
      self?.fetch()
    }.store(in: &subscriptions)
  }
}

// MARK: - Private
private extension DetailsScreenViewModel {
  
  func convertToDate(from originalDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = dateFormatter.date(from: originalDate)
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    let valueDate = dateFormatter.string(from: date!)
    return valueDate
  }
  
  func fetch() {
    guard let articleTitle = article.title,
          let articleSourceName = article.source?.name,
          let articlePublishedAt = article.publishedAt else {return}
    let titleViewState = TitleView.State(title: articleTitle, source: articleSourceName, date: self.convertToDate(from: articlePublishedAt))
    let state = DetailsScreen.Models.State(titleViewState: titleViewState, imageURL: article.urlToImage, content: article.content)
    self.viewStateSubj.send(.loaded(state: state))
  }
}
