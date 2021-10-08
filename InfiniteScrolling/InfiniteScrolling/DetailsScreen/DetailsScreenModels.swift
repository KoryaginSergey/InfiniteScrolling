//
//  DetailsScreenModels.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine
import UIKit

enum DetailsScreen {}

extension DetailsScreen {
  enum Models {}
}

// MARK: - Models View Input/Output
extension DetailsScreen.Models {
  
  // MARK: Input
  struct ViewModelInput {
    let onLoad: AnyPublisher<Void, Never>
  }
  
  // MARK: Output
  enum ViewState: Equatable {
    case idle
    case loaded(state: DetailsScreen.Models.State)// добавить сюда структуру с моделью
  }
  
  enum ViewAction {
  }
  
  enum ViewRoute {
  }
}

// MARK: - Scene Models
extension DetailsScreen.Models {
  
  struct State {
    let id = UUID().hashValue
    let titleViewState: TitleView.State
    let imageURL: URL?
    let content: String?
  }
  
  //
  //    // MARK: List Models
  //    enum Section: Hashable {
  //        case main
  //    }
  //
//      struct Item: Hashable {
//        let item: DetailsScreen.Models.State
//      }
}

extension DetailsScreen.Models.State: Hashable {
  static func == (lhs: DetailsScreen.Models.State, rhs: DetailsScreen.Models.State) -> Bool {
    return lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.titleViewState == rhs.titleViewState && lhs.content == rhs.content
  }
}
