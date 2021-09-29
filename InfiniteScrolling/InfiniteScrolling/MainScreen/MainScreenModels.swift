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
        case loading
        case loaded(sections: [MainScreen.Models.Section])
        case empty
        case failure
    }
    
    enum ViewAction {
    }
    
    enum ViewRoute {
        case dismiss
    }
}

// MARK: - Scene Models
extension MainScreen.Models {
    
    struct State {
      let id = UUID().hashValue
      let titleViewState: TitleView.State
      let image: UIImage?
    }
  
    struct Section: Hashable {
        let items: [Item]
    }
    
    // MARK: List Models
//    enum Section: Hashable {
//        case horizontalSection(items: [Item])
//        case verticalSection(items: [Item])
//    }
    
    enum Item: Hashable {
        case topItem(state: MainScreen.Models.State)
        case bottomItem(state: MainScreen.Models.State)
    }
}

extension MainScreen.Models.State: Hashable {
  static func == (lhs: MainScreen.Models.State, rhs: MainScreen.Models.State) -> Bool {
    return lhs.id == rhs.id && lhs.image == rhs.image && lhs.titleViewState == rhs.titleViewState
  }
}

