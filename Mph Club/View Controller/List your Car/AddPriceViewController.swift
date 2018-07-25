//
//  AddPriceViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AddPriceViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var fixedPriceTextField: MphTextField!
    @IBOutlet weak var recommendedPriceLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    // Constraints
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixedPriceTextField.delegate = self
        
        button1.setImage(UIImage(named : "group7"), for: UIControlState.normal)
        button2.setImage(UIImage(named : "group7-1"), for: UIControlState.normal)
        fixedPriceTextField.setBottomSingleBorder(color: UIColor.lightGray.cgColor)
        
        let navButton1 = UIBarButtonItem(image: UIImage(named: "arrowLeft28Px"), style: .plain, target: self, action: #selector(AddPriceViewController.close))
        navButton1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = navButton1
        
        self.fixedPriceTextField.keyboardType = UIKeyboardType.decimalPad
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToSetPriceView", sender: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button1(_ sender: UIButton) {
        if button1.isSelected == false {
            button1.isSelected = true
            button1.setImage(UIImage(named : "group7"), for: UIControlState.normal)
            
            button2.isSelected = false
            button2.setImage(UIImage(named : "group7-1"), for: UIControlState.normal)
            
            fixedPriceTextField.isEnabled = false
            
            recommendedPriceLabel.textColor = UIColor.black
            
            fixedPriceTextField.setBottomSingleBorder(color: UIColor.lightGray.cgColor)
        }
        
    }
    
    @IBAction func button2(_ sender: UIButton) {
        if button2.isSelected == false {
            button2.isSelected = true
            button2.setImage(UIImage(named : "group7"), for: UIControlState.normal)
            
            button1.isSelected = false
            button1.setImage(UIImage(named : "group7-1"), for: UIControlState.normal)
            
            fixedPriceTextField.isEnabled = true
            
            recommendedPriceLabel.textColor = UIColor.lightGray
            
            fixedPriceTextField.setBottomSingleBorder(color: UIColor.black.cgColor)
            
            fixedPriceTextField.becomeFirstResponder()
        }
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


// MARK: UITextFieldDelegate
extension AddPriceViewController: UITextFieldDelegate {
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
extension AddPriceViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyboardSize.height > 250 {
                keyboardHeight = keyboardSize.height - 144
            } else {
                keyboardHeight = keyboardSize.height
            }
            
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            
            var unwrappedActiveFieldY = CGFloat()
            if let unwrapped = activeField?.frame.origin.y {
                unwrappedActiveFieldY = unwrapped
            }
            
            var unwrappedActiveFieldHeight = CGFloat()
            if let unwrapped = activeField?.frame.size.height {
                unwrappedActiveFieldHeight = unwrapped
            }
            
            let distanceToBottom = (self.scrollView.frame.size.height - 87) - unwrappedActiveFieldY - unwrappedActiveFieldHeight
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 40)
            })
        }
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight
            
            self.scrollView.contentOffset = self.lastOffset
        }
        
        keyboardHeight = nil
    }
}
