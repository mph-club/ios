//
//  LicenseDetailViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView

class LicenseDetailViewController: UIViewController, UIScrollViewDelegate {

    var oneTime = true
    var isState = true
    
    @IBOutlet weak var stateTextField: APJTextPickerView!
    @IBOutlet weak var licenseNumberTextField: MphTextField!
    @IBOutlet weak var firstNameTextField: MphTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // Constraints
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        licenseNumberTextField.delegate = self
        firstNameTextField.delegate = self
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Add touch gesture for contentView
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
        
        initStatePickerView()
        
        let button1 = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(LicenseDetailViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate var stateStrings = ["Florida", "California", "New York"]
    private func initStatePickerView() {
        stateTextField.type = .strings
        stateTextField.pickerDelegate = self
        stateTextField.dataSource = self
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        
        self.checkFields()
    }
    
    func checkFields() {
        if self.stateTextField.text == "" || self.licenseNumberTextField.text == "" || self.firstNameTextField.text == "" {
            self.present(fireAlert(title: "Missing Field", message: "All fields must be entered."), animated: true)
        } else if self.firstNameTextField.text == "Billy" {
            // Action sheet
            
            
            let fireAction = fireActionSheet(title: "You entered a name that doesn’t match the name on your mph profile.", message: "mph does not allow setting up an account on behalf of another person. To add another driver to your trip, just have that person sign up and get approved to drive before the trip starts.\n Are you  sure that your driver’s license information is correct?")
                
            fireAction.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                self.updateName()
            }))
            
            fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            self.present(fireAction, animated: true)

        } else {
            // perform segue
            self.performSegue(withIdentifier: "goToInsurancePicture", sender: nil)
            
        }
        
    }
    
    
    func updateName() {
        let fireAction = fireActionSheet(title: "In order to keep our market place safe we will update your profile name from “Dan Cardenas” to “Daniel Cardenas”.", message: "In order to keep our market place safe we will update your profile name from “Dan Cardenas” to “Daniel Cardenas”.")
        
        fireAction.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            self.updated()
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(fireAction, animated: true)
    }
    
    func updated() {
        performSegue(withIdentifier: "goToInsurancePicture", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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


extension LicenseDetailViewController: APJTextPickerViewDelegate {
    private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
        print("Date Selected: \(date)")
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1 {
            print("Selected: \(stateStrings[row])")
        }
        
    }
    
    
    
    func checkAllSelected() {
//        if yearPickerView.text != "" && makePickerView.text != "" {
//            nextButtton.backgroundColor = UIColor.black
//        }
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        
        if textPickerView.tag == 1 {
            return stateStrings[row]
        } else {
            return ""
        }
    }
    
}

extension LicenseDetailViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        activeField = pickerView
        if pickerView.tag == 1 {
            return stateStrings.count
        } else {
            return 0
        }
        
    }
}


//////////////////



// MARK: UITextFieldDelegate
extension LicenseDetailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true

    }
    
    private func textFieldShouldBeginEditing(_ textField: APJTextPickerView) -> Bool {
        print("test")
        
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
extension LicenseDetailViewController {
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
    
        
        
        if activeField?.tag == 3 {
            setBottomBorder()
            isState = false
            self.stateTextField.isUserInteractionEnabled = false
            self.licenseNumberTextField.isUserInteractionEnabled = false
        } else if activeField?.tag == 2 {
            setBottomBorder()
            isState = false
            self.stateTextField.isUserInteractionEnabled = false
            self.firstNameTextField.isUserInteractionEnabled = false
        } else {
            isState = true
            self.licenseNumberTextField.isUserInteractionEnabled = false
            self.firstNameTextField.isUserInteractionEnabled = false
        }
        
        
        if isState == false {
            if keyboardHeight != nil {
                return
            }
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                if oneTime == true {
                    keyboardHeight = keyboardSize.height - 144
                    oneTime = false
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

    }
    

    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.stateTextField.isUserInteractionEnabled = true
        self.licenseNumberTextField.isUserInteractionEnabled = true
        self.firstNameTextField.isUserInteractionEnabled = true
        
        if isState == false {
            UIView.animate(withDuration: 0.3) {
                self.constraintContentHeight.constant -= self.keyboardHeight
                if self.lastOffset != nil {
                    self.scrollView.contentOffset = self.lastOffset
                }
                
            }
            keyboardHeight = nil
        }

    }
}
