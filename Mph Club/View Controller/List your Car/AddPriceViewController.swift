//
//  AddPriceViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AddPriceViewController: UIViewController, UIScrollViewDelegate {

    
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
        
        scrollView.delegate = self
        
        fixedPriceTextField.delegate = self
        
        button1.setImage(UIImage(named : "group7"), for: UIControlState.normal)
        button2.setImage(UIImage(named : "group7-1"), for: UIControlState.normal)
        fixedPriceTextField.setBottomSingleBorder(color: UIColor.lightGray.cgColor)
        

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
        
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setBottomBorder()
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            print("reach bottom")
        }
        
        if (scrollView.contentOffset.y <= 0){
            print("reach top")
            self.removeBottomBorder()
        }
        
        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            //not top and not bottom
        }
    }
    
    
    func setBottomBorder() {
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    func removeBottomBorder() {
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }

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
