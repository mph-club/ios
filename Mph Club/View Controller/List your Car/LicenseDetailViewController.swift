//
//  LicenseDetailViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView

class LicenseDetailViewController: UIViewController {

    @IBOutlet weak var stateTextField: APJTextPickerView!
    @IBOutlet weak var licenseNumberTextField: MphTextField!
    @IBOutlet weak var firstNameTextField: MphTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStatePickerView()
        
        let button1 = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(LicenseDetailViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
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
        
        if pickerView.tag == 1 {
            return stateStrings.count
        } else {
            return 0
        }
        
    }
}
