//
//  DetailsScreenModels.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation
import Combine

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
        case loaded()// добавить сюда структуру с моделью
    }

    enum ViewAction {
    }

    enum ViewRoute {
    }
}

// MARK: - Scene Models
//extension DetailsScreen.Models {
//
//    // MARK: List Models
//    enum Section: Hashable {
//        case main
//    }
//
//    enum Item: Hashable {
//    }
//}
