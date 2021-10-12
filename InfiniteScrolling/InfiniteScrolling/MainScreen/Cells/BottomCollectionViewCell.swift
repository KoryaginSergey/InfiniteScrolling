//
//  BottomCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//

import UIKit


final class BottomCollectionViewCell: UICollectionViewCell, NibReusable {
  
  private struct Defaults {
    struct BottomImage {
      static let cornerRadius: CGFloat = 15
    }
  }
  
  @IBOutlet private weak var bottomCellImageView: UIImageView!
  @IBOutlet private weak var viewForTitleView: UIView!
  
  private var titleView: TitleView?
  
  // MARK: - Properties
  var state: MainScreen.Models.State? {
    didSet {
      configure()
    }
  }
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
}

// MARK: - Private methods
private extension BottomCollectionViewCell {
  func setupUI() {
    bottomCellImageView.layer.cornerRadius = Defaults.BottomImage.cornerRadius
    bottomCellImageView.contentMode = .scaleAspectFill
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
  }
  
  func configure() {
    bottomCellImageView.sd_setImage(with: state?.imageURL, placeholderImage: Article.Defaults.articlePlaceholder, options: [], completed: nil)
    titleView?.state = state?.titleViewState
  }
}


