//
//  CarEligibilityViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView


protocol ChangeButtonColorDelegate {
    func setColor(color: UIColor)
}

class TellUsAboutYourCarViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    var delegate: ChangeButtonColorDelegate?
    
//    init(withDelegate delegate: ChangeButtonColorDelegate?) {
//        self.delegate = delegate
//    }
    
    
    var isState = true
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var plateTextField: MphTextField!
    @IBOutlet weak var statePickerView: APJTextPickerView!
    

    @IBOutlet weak var nextButtton: nextButton!

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var carDescriptionLabel: UILabel!
    @IBOutlet weak var carDescTextView: UITextView!
    
    var activeField: UITextView?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    // Constraints
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        plateTextField.delegate = self
        statePickerView.delegate = self
        
        initStatePickerView()
        
        
        carDescTextView.delegate = self
        
        scrollView.delegate = self
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(AboutYourCarViewKeyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AboutYourCarViewKeyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Add touch gesture for contentView
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_returnTextView(gesture:))))
        
        self.setUpTextField(color: UIColor.lightGray.cgColor)
        
        self.carDescTextView.layer.borderWidth = 1
        self.carDescTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(TellUsAboutYourCarViewController.cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TellUsAboutYourCarViewController.doneWithNumberPad))]  // Selector(("doneWithNumberPad"))
        numberToolbar.sizeToFit()
        carDescTextView.inputAccessoryView = numberToolbar
    }
    
    
    @objc func _returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
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
    
    
    
    @objc func cancelNumberPad() {
        carDescTextView.resignFirstResponder()
    }
    
    @objc func doneWithNumberPad() {
        carDescTextView.resignFirstResponder()
    }
    
    
    func normalState() {
        if self.plateTextField.text! != "" && self.statePickerView.text! != "" && self.carDescTextView.text! != "" {
            // turn btn black
            delegate?.setColor(color: UIColor.black)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setUpTextField(color: CGColor) {
        self.stateLabel.textColor = UIColor.lightGray
        self.carDescriptionLabel.textColor = UIColor.lightGray
        self.statePickerView.setBottomSingleBorder(color: color)
    }
    
    fileprivate var stateStrings = ["Florida", "California", "New York", "Atlanta", "Dallas", "New Jersey"]
    private func initStatePickerView() {
        statePickerView.type = .strings
        statePickerView.pickerDelegate = self
        statePickerView.dataSource = self
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 3 {
            self.carDescriptionLabel.textColor = UIColor.black
            self.carDescTextView.layer.borderColor = UIColor.black.cgColor
        }
    }

    
}


extension TellUsAboutYourCarViewController: APJTextPickerViewDelegate {

    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 2 {
            print("Selected: \(stateStrings[row])")
        }
    }
    
    
    
    func checkAllSelected() {
        if plateTextField.text != "" && statePickerView.text != "" {
            nextButtton.backgroundColor = UIColor.black
        }
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        if textPickerView.tag == 2 {
            self.stateLabel.textColor = UIColor.black
            self.statePickerView.setBottomSingleBorder(color: UIColor.black.cgColor)
            return stateStrings[row]
        } else {
            return ""
        }
        
    }
}

extension TellUsAboutYourCarViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            plateTextField.text = textField.text
        }
        
        if textField.tag == 2 {
            statePickerView.text = textField.text
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}


extension TellUsAboutYourCarViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        
        if pickerView.tag == 2 {
            return stateStrings.count
        } else {
            return 0
        }
        
    }
}



// MARK: UITextFieldDelegate
extension TellUsAboutYourCarViewController {

    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("test")
        

        
        if textView.tag == 3 {
            carDescTextView.text = textView.text
        }

        activeField = textView
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        normalState()
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    
}


var isCarDescTextView = false

// MARK: Keyboard Handling
extension TellUsAboutYourCarViewController {
    
    
    @objc func AboutYourCarViewKeyboardWillShow(notification: NSNotification) {
        
        

        if activeField?.tag == 3 {
            setBottomBorder()
            isCarDescTextView = true
            self.plateTextField.isUserInteractionEnabled = false
            self.statePickerView.isUserInteractionEnabled = false
        }
        

        
        if isCarDescTextView == true {
            
            
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
                
                let distanceToBottom = self.scrollView.frame.size.height - unwrappedActiveFieldY - unwrappedActiveFieldHeight
                let collapseSpace = keyboardHeight - distanceToBottom
                
                
                // set new offset for scroll view
                UIView.animate(withDuration: 0.3, animations: {
                    self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 105)
                })
            }
        } //
        
    }
    
    
    
    @objc func AboutYourCarViewKeyboardWillHide(notification: NSNotification) {
        
        self.normalState()
        
        self.plateTextField.isUserInteractionEnabled = true
        self.statePickerView.isUserInteractionEnabled = true
        self.carDescTextView.isUserInteractionEnabled = true
        
       if isCarDescTextView == true {

            UIView.animate(withDuration: 0.3) {
                
                if self.keyboardHeight != nil {
                    self.constraintContentHeight.constant -= self.keyboardHeight
                    if self.lastOffset != nil {
                        self.scrollView.contentOffset = self.lastOffset
                    }
                }

                
                self.keyboardHeight = nil
                isCarDescTextView = false
                
            }

       }
        
    }
}


