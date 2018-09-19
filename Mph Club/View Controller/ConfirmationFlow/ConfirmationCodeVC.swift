//
//  ConfirmationCodeVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 9/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class ConfirmationCodeVC: UIViewController {

    
    var sentTo: String?
    var user: AWSCognitoIdentityUser?
    var password: String?

    
    @IBOutlet weak var sentToLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var code: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        self.username.text = self.user!.username;
        self.sentToLabel.text = "Code sent to: \(self.sentTo!)"
    }
    
    func customNavBar() {
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.backArrowIcon), style: .plain, target: self, action: #selector(ConfirmationCodeVC.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.shadowImage = UIColor.lightGray.as1ptImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToSignUp", sender: nil)
    }
    
    // MARK: IBActions
    
    // handle confirm sign up
    @IBAction func confirm(_ sender: AnyObject) {
        guard let confirmationCodeValue = self.code.text, !confirmationCodeValue.isEmpty else {
            let alertController = UIAlertController(title: "Confirmation code missing.",
                                                    message: "Please enter a valid confirmation code.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion:  nil)
            return
        }
        self.user?.confirmSignUp(self.code.text!, forceAliasCreation: true).continueWith {[weak self] (task: AWSTask) -> AnyObject? in
            guard let strongSelf = self else { return nil }
            DispatchQueue.main.async(execute: {
                if let error = task.error as NSError? {
                    let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                            message: error.userInfo["message"] as? String,
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    
                    strongSelf.present(alertController, animated: true, completion:  nil)
                } else {
                  //  _ = self?.tabBarController?.selectedIndex = 0
                  //  self?.username.text = nil
                      self?.dismiss(animated: true, completion: nil)
                  //   self?.performSegue(withIdentifier: "TabView", sender: nil)
                    
                    // LOGIN USER

                }
            })
            return nil
        }
    }
    
    // handle code resend action
    @IBAction func resend(_ sender: AnyObject) {
        self.user?.resendConfirmationCode().continueWith {[weak self] (task: AWSTask) -> AnyObject? in
            guard let _ = self else { return nil }
            DispatchQueue.main.async(execute: {
                if let error = task.error as NSError? {
                    let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                            message: error.userInfo["message"] as? String,
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    
                    self?.present(alertController, animated: true, completion:  nil)
                } else if let result = task.result {
                    let alertController = UIAlertController(title: "Code Resent",
                                                            message: "Code resent to \(result.codeDeliveryDetails?.destination! ?? " no message")",
                        preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            })
            return nil
        }
    }

}
