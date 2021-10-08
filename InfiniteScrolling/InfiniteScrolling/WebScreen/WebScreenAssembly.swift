//
//  WebScreenAssembly.swift
//  InfiniteScrolling
//
//  Created by macuser on 08.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit


extension WebScreen {
  enum Assembly {}
}

extension WebScreen.Assembly {
  static func createModule(with viewModel: WebScreenViewModelProtocol) -> UIViewController {
    let viewController = WebScreenViewController.instantiate()
    viewController.setDependencies(viewModel: viewModel)
    return viewController
  }
}
