//
//  ViewLoadingManager.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/7/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

protocol ViewLoadingManagerView {
    //
    var frame: CGRect { get }
    //
    func showLoading()
    func hideLoading()
    func use(_ view: UIView)
    func dontUse(viewWithTag tag: Int)
}

final class ViewLoadingManager {
    private init() {}
}

// ====================
// MARK: - Loading View
// ====================
extension ViewLoadingManager {
    
    static func presentLoadingView<ViewType: UITableView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: UICollectionView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: ViewLoadingManagerView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func hideLoadingView<ViewType: UITableView>(from view: ViewType) {
        view.hideLoading()
    }
    
    static func hideLoadingView<ViewType: UICollectionView>(from view: ViewType) {
        view.hideLoading()
    }
    
    static func hideLoadingView<ViewType: ViewLoadingManagerView>(from view: ViewType) {
        view.hideLoading()
    }
    
}

// ======================
// MARK: - NoContent View
// ======================
extension ViewLoadingManager {
    static func presentNoContentView<ViewType: UITableView>(in view: ViewType, with message: String) {
        guard let noContentView = noContentView(with: message) else {
            return
        }
        noContentView.frame = view.frame
        noContentView.tag = 4000
        view.use(noContentView)
    }
    
    static func hideNoContentView<ViewType: UICollectionView>(from view: ViewType) {
        view.dontUse(viewWithTag: 4000)
    }
    
    static func presentNoContentView<ViewType: ViewLoadingManagerView>(in view: ViewType, with message: String) {
        guard let noContentView = noContentView(with: message) else {
            return
        }
        noContentView.tag = 4000
        noContentView.frame = view.frame
        view.use(noContentView)
    }
    
    static func hideNoContentView<ViewType: UITableView>(from view: ViewType) {
        view.dontUse(viewWithTag: 4000)
    }
    
    static func presentNoContentView<ViewType: UICollectionView>(in view: ViewType, with message: String) {
        guard let noContentView = noContentView(with: message) else {
            return
        }
        noContentView.tag = 4000
        noContentView.frame = view.frame
        view.use(noContentView)
    }
    
    static func hideNoContentView<ViewType: ViewLoadingManagerView>(from view: ViewType) {
        view.dontUse(viewWithTag: 4000)
    }
    
    // ========================
    // MARK: - Private Function
    // ========================
    private static func noContentView(with message: String) -> NoContentView? {
        let noContentView = NoContentView.loadFromNib()
        noContentView.setContent(message)
        noContentView.tag = 4000
        return noContentView
    }
    
}
