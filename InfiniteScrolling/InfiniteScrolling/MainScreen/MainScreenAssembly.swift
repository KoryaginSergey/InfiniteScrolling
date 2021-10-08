//
//  MainScreenAssembly.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit


extension MainScreen {
  enum Assembly {}
}

extension MainScreen.Assembly {
  static func createModule(with viewModel: MainScreenViewModelProtocol) -> UIViewController {
    let viewController = MainScreenViewController.instantiate()
    viewController.setDependencies(viewModel: viewModel)
    return viewController
  }
}
