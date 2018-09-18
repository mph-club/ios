//
//  SignInViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 9/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import Foundation
import AWSCognitoIdentityProvider


class SignInViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
//    var response: AWSCognitoIdentityUserGetDetailsResponse?
//    var user: AWSCognitoIdentityUser?
//    var pool: AWSCognitoIdentityUserPool?
    
    var loginSlideViewController = LoginSlideViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)
//        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
//        if (self.user == nil) {
//            self.user = self.pool?.currentUser()
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signInPressed(_ sender: AnyObject) {
        if (self.username.text != nil && self.password.text != nil) {
            let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: self.username.text!, password: self.password.text! )
            self.passwordAuthenticationCompletion?.set(result: authDetails)
            print(authDetails!)
            
        
 
            
        } else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter a valid user name and password",
                                                    preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alertController.addAction(retryAction)
        }
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginSlideViewController = segue.destination as? LoginSlideViewController {
            loginSlideViewController.loginSlideDelegate = self 
        }
    }
    
    
    @objc func didChangePageControlValue() {
            //loginSlideViewController.scrollToViewController(index: pageControl.currentPage)
    }
    
}


extension SignInViewController: AWSCognitoIdentityPasswordAuthentication {
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        DispatchQueue.main.async {
            if (self.usernameText == nil) {
              //  self.usernameText = authenticationInput.lastKnownUsername
            }
        }
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.username.text = nil
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension UIViewController {
    func showAlertError(message: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension SignInViewController: LoginSlideViewControllerDelegate {
    
    func loginSlideViewController(LoginSlidePageViewController: LoginSlideViewController,
                                  didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func loginSlideViewController(LoginSlidePageViewController: LoginSlideViewController,
                                  didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
