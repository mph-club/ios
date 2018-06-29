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
        

      //  loginSlideViewController.loginSlideDelegate = self
        pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginSlideViewController = segue.destination as? LoginSlideViewController {
            loginSlideViewController.loginSlideDelegate = self
            // self.loginSlideViewController = loginSlideViewController
        }
    }
  
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        if let loginSlideViewController = segue.destination as? LoginSlideViewController {
//
//           // self.loginSlideViewController = loginSlideViewController
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    @objc func didChangePageControlValue() {
        loginSlideViewController.scrollToViewController(index: pageControl.currentPage)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    


}

extension LoginSlideMainViewController: LoginSlideViewControllerDelegate {
    
    func loginSlideViewController(tutorialPageViewController: LoginSlideViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func loginSlideViewController(tutorialPageViewController: LoginSlideViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}

//extension LoginSlideMainViewController: LoginSlideViewControllerDelegate {
//    func loginSlideViewController(tutorialPageViewController: LoginSlideViewController, didUpdatePageCount count: Int) {
//        pageControl.numberOfPages = count
//    }
//
//    func loginSlideViewController(tutorialPageViewController: LoginSlideViewController, didUpdatePageIndex index: Int) {
//        pageControl.currentPage = index
//    }
//
//}
