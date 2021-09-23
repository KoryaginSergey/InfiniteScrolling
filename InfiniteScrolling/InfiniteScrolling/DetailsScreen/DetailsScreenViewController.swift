//
//  DetailsScreenViewController.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import Combine

final class DetailsScreenViewController: UIViewController, StoryboardBased {

    // MARK: - Properties
    private var viewModel: DetailsScreenViewModelProtocol?
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
extension DetailsScreenViewController {

    func setDependencies(viewModel: DetailsScreenViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - Bind
private extension DetailsScreenViewController {
    func bind(to viewModel: DetailsScreenViewModelProtocol?) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = DetailsScreen.Models.ViewModelInput(onLoad: onLoad.eraseToAnyPublisher())
        viewModel?.process(input: input)
        
        viewModel?.viewState
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                self?.render(state)
            }).store(in: &subscriptions)

        viewModel?.route
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] route in
                self?.handleRoute(route)
            }).store(in: &subscriptions)

        viewModel?.viewAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] action in
                self?.handleAction(action)
            }).store(in: &subscriptions)
    }
    
    func render(_ state: DetailsScreen.Models.ViewState) {
        switch state {
        case .idle:
            break
        case .loading:
            startLoading()
        case .loaded:
            stopLoading()
        case .empty:
            stopLoading()
        case .failure:
            stopLoading()
        }
    }

    func handleAction(_ action: DetailsScreen.Models.ViewAction) {
        switch action {
            //show alert
            //scrollToTop
            // ...
        }
    }
    
    func handleRoute(_ route: DetailsScreen.Models.ViewRoute) {
        switch route {
        }
    }
}

// MARK: - Private
private extension DetailsScreenViewController {

    func setup() {
    }
    
    func startLoading() {
    }
    
    func stopLoading() {
    }
}
