//
//  FAQViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/4/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import WebKit

final class FAQViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Web View
    @IBOutlet private weak var webView: WKWebView!
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension FAQViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let myURL = URL(string: "https://www.apple.com") else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
}
