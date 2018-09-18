//
//  LoginSlideMainViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 6/27/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class LoginSlideMainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var loginSlideViewController = LoginSlideViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginSlideViewController = segue.destination as? LoginSlideViewController {
            loginSlideViewController.loginSlideDelegate = self
        }
    }
  

    @objc func didChangePageControlValue() {
   //     loginSlideViewController.scrollToViewController(index: pageControl.currentPage)
    }
 


}

extension LoginSlideMainViewController: LoginSlideViewControllerDelegate {
    
    func loginSlideViewController(LoginSlidePageViewController: LoginSlideViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func loginSlideViewController(LoginSlidePageViewController: LoginSlideViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}

