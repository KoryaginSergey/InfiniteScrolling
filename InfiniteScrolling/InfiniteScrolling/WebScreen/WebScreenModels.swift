//
//  WebScreenModels.swift
//  InfiniteScrolling
//
//  Created by macuser on 08.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine


enum WebScreen {}

extension WebScreen {
  enum Models {}
}

// MARK: - Models View Input/Output

extension WebScreen.Models {
  
  // MARK: Input
  
  struct ViewModelInput {
    let onLoad: AnyPublisher<Void, Never>
  }
  
  // MARK: Output
  
  enum ViewState: Equatable {
    case idle
    case loaded(state: WebScreen.Models.State)
  }
}

// MARK: - Scene Models

extension WebScreen.Models {
  struct State {
    let urlAddress: URL?
  }
}

extension WebScreen.Models.State: Hashable {
  static func == (lhs: WebScreen.Models.State, rhs: WebScreen.Models.State) -> Bool {
    return lhs.urlAddress == rhs.urlAddress
  }
}
