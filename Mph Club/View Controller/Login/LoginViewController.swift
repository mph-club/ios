//
//  LoginViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 6/27/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    let emailDummy = "alex@mphclub.com"
    let passwordDummy = "alex123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fast login
        self.emailTextField.text = "alex@mphclub.com"
        self.pwTextField.text = "alex123"
        
        addToolBar()
    }
    
    
    func addToolBar() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        self.emailTextField.inputAccessoryView = toolbar
        self.pwTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        if self.emailTextField.text == emailDummy && self.pwTextField.text == passwordDummy {
            performSegue(withIdentifier: "goToTabView", sender: nil)
        } else {
            print("Incorrect Password")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    
}
