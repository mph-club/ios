//
//  ParallaxTableView.swift
//  Mph Club
//
//  Created by behzad ardeh on 10/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ParallaxTableView: UITableView {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var imageViewHeightConstraint: NSLayoutConstraint? {
        didSet {
            imageViewBottomConstraint?.constant = tableHeaderView?.frame.height ?? 0.0
        }
    }
    private var imageViewBottomConstraint: NSLayoutConstraint?
}

// ==================
// MARK: - Table View
// ==================

// MARK: Life Cycle
extension ParallaxTableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        guard let headerView = tableHeaderView else { return }
        if imageViewHeightConstraint == nil {
            if let imageView = headerView.subviews.first as? UIImageView {
                imageViewHeightConstraint = imageView.constraints.filter { $0.identifier == "height" }.first
                imageViewBottomConstraint = headerView.constraints.filter { $0.identifier == "bottom" }.first
            }
        }
        
        /// contentOffset - is a dynamic value from the top
        /// adjustedContentInset fixed valie from the top
        let offsetY = -contentOffset.y // + adjustedContentInset.top)
        
        imageViewHeightConstraint?.constant = max(headerView.bounds.height, headerView.bounds.height + offsetY)
        imageViewBottomConstraint?.constant = offsetY >= 0 ? 0 : offsetY / 2
        
        headerView.clipsToBounds = offsetY <= 0
    }
}
