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
import CoreData


protocol MainScreenViewModelProtocol: AnyObject {
  var viewState: AnyPublisher<MainScreen.Models.ViewState, Never> { get }
  
  func process(input: MainScreen.Models.ViewModelInput)
  func retrieveNewData(at indexPath: IndexPath)
}

final class MainScreenViewModel: NSObject{
  
  // MARK: - Properties
  private let viewStateSubj = CurrentValueSubject<MainScreen.Models.ViewState, Never>(.idle)
  private var subscriptions = Set<AnyCancellable>()
  
  var topPage = Page(size: 10, page: 1)
  var bottomPage = Page(size: 10, page: 1)
  
  var isTopLoading: Bool = false
  var isBottomLoading: Bool = false
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
      if self.topPage.isFull { return }
      self.isTopLoading = true
      self.fetchTopItems { [weak self] in
        self?.isTopLoading = false
      }
    case 1:
      if isBottomLoading { return }
      if self.bottomPage.isFull { return }
      self.isBottomLoading = true
      self.fetchBottomItems { [weak self] in
        self?.isBottomLoading = false
      }
    default: break
    }
  }
}

// MARK: - Private
private extension MainScreenViewModel {
  func fetch() {
    fetchTopItems(closure: nil)
    fetchBottomItems(closure: nil)
  }
  
  func fetchTopItems(closure: (()->Void)?) {
    PostServices.shared.getTopPosts(page: topPage) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case let .success(data):
        guard let articles = data.articles else { return }
        articles.saveModels(pageObject: self.bottomPage, type: .top)
        self.topPage.page = self.topPage.page + 1
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
        articles.saveModels(pageObject: self.bottomPage, type: .bottom)
        self.bottomPage.page = self.bottomPage.page + 1
      case let .failure(error):
        print(error)
      }
      closure?()
    }
  }
}

private extension Array where Element == Article {
  func saveModels(pageObject: Page, type: CDModelArticle.ArticleType) {
    let maxIndex = pageObject.page * pageObject.size
    let minIndex = maxIndex - pageObject.size
    for (index, element) in self.enumerated() {
      let id = minIndex + index
      CDModelArticle.store(by: Int16(id), type: type, object: element)
    }
    DataModels.sharedInstance.saveContext()
  }
}


