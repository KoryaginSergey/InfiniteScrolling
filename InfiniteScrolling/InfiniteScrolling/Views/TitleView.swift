//
//  TitleView.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//

import UIKit
import Reusable

final class TitleView: XibView {
  
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var sourceLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
    
    struct State {
        
    }
    
    // MARK: - Properties
    var state: State? {
        didSet {
            configure()
        }
    }
    
    // MARK: - Lifecycle
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupUI()
    }
 
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
    }
     */
}

// MARK: - Internal methods
extension TitleView {
    
}

// MARK: - Private methods
private extension TitleView {
    
    func setupUI() {
        
    }
    
    func configure() {
        
    }
}

/*
// MARK: - TitleView.State + Hashable
extension TitleView.State: Hashable {
    
}
 */
