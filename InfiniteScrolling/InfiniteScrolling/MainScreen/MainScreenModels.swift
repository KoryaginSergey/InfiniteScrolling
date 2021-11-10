//
//  MainScreenModels.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import Foundation
import Combine


enum MainScreen {}

extension MainScreen {
  enum Models {}
}

// MARK: - Models View Input/Output
extension MainScreen.Models {
  
  // MARK: Input
  struct ViewModelInput {
    let onLoad: AnyPublisher<Void, Never>
  }
  
  // MARK: Output
  enum ViewState: Equatable {
    case idle
    case loaded(sections: [MainScreen.Models.Section])
  }
}

// MARK: - Scene Models
extension MainScreen.Models {
  struct State {
    let id: Int16
    let titleViewState: TitleView.State?
    let imageURL: URL?
  }
  
  struct Section: Hashable {
    let id: Int
    let items: [Item]
  }
  
  enum Item: Hashable {
    case topItem(state: MainScreen.Models.State)
    case bottomItem(state: MainScreen.Models.State)
  }
}

extension MainScreen.Models.State: Hashable {
  static func == (lhs: MainScreen.Models.State, rhs: MainScreen.Models.State) -> Bool {
    return lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.titleViewState == rhs.titleViewState
  }
}

