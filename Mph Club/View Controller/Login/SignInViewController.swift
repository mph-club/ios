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
import Mixpanel

class SignInViewController: UIViewController, UIScrollViewDelegate {
     var isState = true
     var activeField: UITextField?
     var lastOffset: CGPoint!
     var keyboardHeight: CGFloat!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    
    var loginSlideViewController = LoginSlideViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        Mixpanel.mainInstance().track(event: "Second Event")
        self.scrollView.scrollsToTop = false
        hideKeyboardWhenTappedAround()
        pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)

        self.username.delegate = self
        self.password.delegate = self
        
        // Add touch gesture for contentView
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SignInViewController.returnTextView(gesture:))))
    }
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.createAccountBtn.layer.borderWidth = 1.5
        self.createAccountBtn.layer.borderColor = UIColor.black.cgColor
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > CGPoint.zero.y else {
            scrollView.setContentOffset(CGPoint.zero, animated: false)
            return
        }
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
    
    @IBAction func unwindToSignIn(segue: UIStoryboardSegue) {}
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



// MARK: UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}




    // MARK: Keyboard Handling
extension SignInViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        view.frame.origin.y = -keyboardRect.height
    }
        
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
