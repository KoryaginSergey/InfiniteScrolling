//
//  DetailsScreenAssembly.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

extension DetailsScreen {
    enum Assembly {}
}

extension DetailsScreen.Assembly {
    static func createModule(with viewModel: DetailsScreenViewModelProtocol) -> UIViewController {
        let viewController = DetailsScreenViewController.instantiate()
        viewController.setDependencies(viewModel: viewModel)
        return viewController
    }
}
