//
//  TopCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//

import UIKit


final class TopCollectionViewCell: UICollectionViewCell, NibReusable {
  
  private struct Defaults {
    struct TopView {
      static let cornerRadius: CGFloat = 15
    }
    
    struct TitleView {
      static let cornerRadius: CGFloat = 15
    }
  }
  
  @IBOutlet private weak var topCellView: UIView!
  @IBOutlet private weak var topCellImageView: UIImageView!
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
  
  /*
   override func layoutSubviews() {
   super.layoutSubviews()
   }
   
   override func prepareForReuse() {
   super.prepareForReuse()
   }
   */
}

// MARK: - Internal methods
extension TopCollectionViewCell {
  
}

// MARK: - Private methods
private extension TopCollectionViewCell {
  
  func setupUI() {
    topCellView.layer.cornerRadius = Defaults.TopView.cornerRadius
    topCellImageView.contentMode = .scaleAspectFill
    topCellView.clipsToBounds = true
    
    let titleView = TitleView.loadFromNib()
    
    viewForTitleView.addSubview(titleView)
    titleView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleView.topAnchor.constraint(equalTo: viewForTitleView.topAnchor),
      titleView.bottomAnchor.constraint(equalTo: viewForTitleView.bottomAnchor),
      titleView.leftAnchor.constraint(equalTo: viewForTitleView.leftAnchor),
      titleView.rightAnchor.constraint(equalTo: viewForTitleView.rightAnchor)
    ])
    viewForTitleView.layer.cornerRadius = Defaults.TitleView.cornerRadius
    viewForTitleView.clipsToBounds = true
    
    self.titleView = titleView
  }
  
  func configure() {
    topCellImageView.sd_setImage(with: state?.imageURL, placeholderImage: UIImage(named: "news1"), options: [], completed: nil)
    titleView?.state = state?.titleViewState
//    state?.completionHandler()
  }
}

 // MARK: - TopCollectionViewCell.State + Hashable
//extension TopCollectionViewCell.State: Hashable {
//  static func == (lhs: TopCollectionViewCell.State, rhs: TopCollectionViewCell.State) -> Bool {
//    return lhs.id == rhs.id && lhs.image == rhs.image && lhs.titleViewState == rhs.titleViewState
//  }
//}
