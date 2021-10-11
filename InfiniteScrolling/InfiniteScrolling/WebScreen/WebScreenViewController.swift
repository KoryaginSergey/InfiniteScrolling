//
//  WebScreenViewController.swift
//  InfiniteScrolling
//
//  Created by macuser on 08.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import Combine
import WebKit


final class WebScreenViewController: UIViewController, StoryboardBased {
  
  @IBOutlet private weak var webView: WKWebView!
  
  
  // MARK: - Properties
  
  private var viewModel: WebScreenViewModelProtocol?
  private let onLoad = PassthroughSubject<Void, Never>()
  
  public var subscriptions = Set<AnyCancellable>()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind(to: viewModel)
    onLoad.send(())
  }
}

// MARK: - Internal methods

extension WebScreenViewController {
  
  func setDependencies(viewModel: WebScreenViewModelProtocol) {
    self.viewModel = viewModel
  }
}

// MARK: - Bind

private extension WebScreenViewController {
  func bind(to viewModel: WebScreenViewModelProtocol?) {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
    
    let input = WebScreen.Models.ViewModelInput(onLoad: onLoad.eraseToAnyPublisher())
    viewModel?.process(input: input)
    
    viewModel?.viewState
      .removeDuplicates()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] state in
        self?.render(state)
      }).store(in: &subscriptions)
    
  }
  
  func render(_ state: WebScreen.Models.ViewState) {
    switch state {
    case .idle:
      break
    case .loaded(state: let item):
      webView.load(URLRequest(url: item.urlAddress!))
    }
  }
}

// MARK: - Private

private extension WebScreenViewController {
  
  func setup() {
  }
  
  func startLoading() {
  }
  
  func stopLoading() {
  }
}
