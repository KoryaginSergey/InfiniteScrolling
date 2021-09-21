//
//  BottomCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//

import UIKit
import Reusable

final class BottomCollectionViewCell: UICollectionViewCell, NibReusable {

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
extension BottomCollectionViewCell {
    
}

// MARK: - Private methods
private extension BottomCollectionViewCell {
    
    func setupUI() {
        
    }
    
    func configure() {
        
    }
}

/*
// MARK: - BottomCollectionViewCell.State + Hashable
extension BottomCollectionViewCell.State: Hashable {
    
}
 */
