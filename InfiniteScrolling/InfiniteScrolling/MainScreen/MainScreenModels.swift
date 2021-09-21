//
//  MainScreenModels.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

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
        case loaded
        case empty
        case failure
    }

    enum ViewAction {
    }

    enum ViewRoute {
    }
}

// MARK: - Scene Models
//extension MainScreen.Models {
//
//    // MARK: List Models
//    enum Section: Hashable {
//        case main
//    }
//
//    enum Item: Hashable {
//    }
//}
