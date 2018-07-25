//
//  VerifyPhoneViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/16/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController {

    @IBOutlet weak var phoneTextField: MphTextField!
    @IBOutlet weak var nextButton: nextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneTextField.keyboardType = UIKeyboardType.decimalPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backToProgress(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToProgress", sender: nil)
    }
    
}


extension VerifyPhoneViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        print("Begin")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if phoneTextField.text! != "" {
            nextButton.backgroundColor = UIColor.black
        }
         print("End")
    }
    
}


extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
}
