//
//  CreateAccountViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 6/28/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

final class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    var pool: AWSCognitoIdentityUserPool?
    var sentTo: String?
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        self.email.delegate = self
        self.password.delegate = self
        self.phone.delegate = self
        self.pool = AWSCognitoIdentityUserPool.init(forKey: AWSCognitoUserPoolsSignInProviderKey)
    }
    
    func customNavBar() {
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.backArrowIcon), style: .plain, target: self, action: #selector(CreateAccountViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.shadowImage = UIColor.lightGray.as1ptImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToSignIn", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func signUp(_ sender: UIButton) {
        
        guard let emailNameValue = self.email.text, !emailNameValue.isEmpty,
            let passwordValue = self.password.text, !passwordValue.isEmpty else {
                let alertController = UIAlertController(title: "Missing Required Fields",
                                                        message: "emailName / Password are required for registration.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
        }
        
        var attributes = [AWSCognitoIdentityUserAttributeType]()
        
        if let phoneValue = self.phone.text, !phoneValue.isEmpty {
            guard let phone = AWSCognitoIdentityUserAttributeType() else { return }
            phone.name = "phone_number"
            phone.value = phoneValue
            attributes.append(phone)
        }
        
        if let emailValue = self.email.text, !emailValue.isEmpty {
            guard let email = AWSCognitoIdentityUserAttributeType() else { return }
            email.name = "email"
            email.value = emailValue
            attributes.append(email)
        }
        
        //sign up the user
        self.pool?.signUp(emailNameValue, password: passwordValue, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
            
            guard let strongSelf = self else { return nil }
            
            DispatchQueue.main.async(execute: {
                if let error = task.error as NSError? {
                    let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                            message: error.userInfo["message"] as? String,
                                                            preferredStyle: .alert)
                    let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                    alertController.addAction(retryAction)
                    
                    self?.present(alertController, animated: true, completion: nil)
                } else if let result = task.result  {
                    // handle the case where user has to confirm his identity via email / SMS
                    if result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed {
                        self?.performSegue(withIdentifier: "confirmSignUpSegue", sender: result)
                    } else {
                        _ = strongSelf.navigationController?.popToRootViewController(animated: true)
                    }
                }
                
            })
            return nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "unwindToSignIn" {
            let sender = sender as? AWSCognitoIdentityUserPoolSignUpResponse
            if let confirmationCodeVC = segue.destination as? ConfirmationCodeVC {
                confirmationCodeVC.user = sender?.user
                confirmationCodeVC.sentTo = sender?.codeDeliveryDetails?.destination
                confirmationCodeVC.password = self.password.text
            }
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func unwindToSignUp(segue: UIStoryboardSegue) {}
    
}
