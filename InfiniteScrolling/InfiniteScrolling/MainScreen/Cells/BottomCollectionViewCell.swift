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
    struct TitleView {
      
    }
  }
  
  @IBOutlet private weak var bottomCellImageView: UIImageView!
  @IBOutlet private weak var viewForTitleView: UIView!
  
  private var titleView: TitleView?
  
    struct State {
      let id = UUID().hashValue
      let titleViewState: TitleView.State
      let image: UIImage?
    }
    
    // MARK: - Properties
    var state: State? {
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
extension BottomCollectionViewCell {
    
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
      bottomCellImageView.image = state?.image
      titleView?.state = state?.titleViewState
    }
}

 // MARK: - BottomCollectionViewCell.State + Hashable

extension BottomCollectionViewCell.State: Hashable {
  static func == (lhs: BottomCollectionViewCell.State, rhs: BottomCollectionViewCell.State) -> Bool {
    return lhs.id == rhs.id && lhs.image == rhs.image && lhs.titleViewState == rhs.titleViewState
  }
}
 
