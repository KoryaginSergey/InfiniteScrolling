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
  
  @IBOutlet private weak var topView: UIView!
  @IBOutlet private weak var bottomView: UIView!
  @IBOutlet private weak var detailsImageView: UIImageView!
  @IBOutlet private weak var viewForTitleView: UIView!
  @IBOutlet private weak var textView: UITextView!
  
  private var titleView: TitleView?
  
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
  }
  
  func render(_ state: DetailsScreen.Models.ViewState) {
    switch state {
    case .idle:
      break
    case .loaded(state: let item):
      textView.text = item.content
      detailsImageView.sd_setImage(with: item.imageURL,
                                   placeholderImage: Article.Defaults.articlePlaceholder,
                                   options: [], completed: nil)
      titleView?.state = item.titleViewState
      break
    }
  }
}

// MARK: - Private

private extension DetailsScreenViewController {
  func setup() {
    let titleView = TitleView.loadFromNib()
    viewForTitleView.addSubview(titleView)
    titleView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleView.topAnchor.constraint(equalTo: viewForTitleView.topAnchor),
      titleView.bottomAnchor.constraint(equalTo: viewForTitleView.bottomAnchor),
      titleView.leftAnchor.constraint(equalTo: viewForTitleView.leftAnchor),
      titleView.rightAnchor.constraint(equalTo: viewForTitleView.rightAnchor)
    ])
    self.titleView = titleView
    topView.layer.cornerRadius = 45
    topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    bottomView.layer.cornerRadius = 45
    bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
}
