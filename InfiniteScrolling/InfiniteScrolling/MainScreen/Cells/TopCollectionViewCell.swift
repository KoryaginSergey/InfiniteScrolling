//
//  TopCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//

import UIKit
import Reusable

final class TopCollectionViewCell: UICollectionViewCell, NibReusable {
  
  
  @IBOutlet private weak var topCellView: UIView!
  @IBOutlet private weak var topCellImageView: UIImageView!
  @IBOutlet private weak var viewForTitleView: UIView!
  

    struct State {
        
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
extension TopCollectionViewCell {
    
}

// MARK: - Private methods
private extension TopCollectionViewCell {
    
    func setupUI() {
        
    }
    
    func configure() {
        
    }
}

/*
// MARK: - TopCollectionViewCell.State + Hashable
extension TopCollectionViewCell.State: Hashable {
    
}
 */
