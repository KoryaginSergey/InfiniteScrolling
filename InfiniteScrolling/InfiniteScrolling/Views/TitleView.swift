//
//  TitleView.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//

import UIKit
//import Reusable

final class TitleView: UIView, NibLoadable {
  
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var sourceLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
    
  struct State {
      let title: String
      let source: String
      let date: String
      
      init(title: String, source: String, date: String) {
        self.title = title
        self.source = source
        self.date = date
        }
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
     */
}

// MARK: - Internal methods
extension TitleView {
    
}

// MARK: - Private methods
private extension TitleView {
    
    func setupUI() {
      sourceLabel.textColor = .systemBlue
    }
    
    func configure() {
      titleLabel.text = state?.title
      sourceLabel.text = state?.source
      dateLabel.text = state?.date
    }
}

// MARK: - TitleView.State + Hashable
extension TitleView.State: Hashable {
  static func == (lhs: TitleView.State, rhs: TitleView.State) -> Bool {
    return lhs.title == rhs.title && lhs.source == rhs.source && lhs.date == rhs.date
  }
}
