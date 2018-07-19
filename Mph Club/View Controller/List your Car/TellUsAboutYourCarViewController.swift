//
//  CarEligibilityViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView

class TellUsAboutYourCarViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var plateTextField: MphTextField!
    @IBOutlet weak var statePickerView: APJTextPickerView!
    

    @IBOutlet weak var nextButtton: nextButton!

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var carDescriptionLabel: UILabel!
    @IBOutlet weak var carDescTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStatePickerView()
        
        setUpTextField(color: UIColor.lightGray.cgColor)
        
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(TellUsAboutYourCarViewController.cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TellUsAboutYourCarViewController.doneWithNumberPad))]  // Selector(("doneWithNumberPad"))
        numberToolbar.sizeToFit()
        carDescTextView.inputAccessoryView = numberToolbar
    }
    
    

    
    @objc func cancelNumberPad() {
        //Cancel with number pad
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        carDescTextView.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setUpTextField(color: CGColor) {
        self.stateLabel.textColor = UIColor.lightGray
        self.carDescriptionLabel.textColor = UIColor.lightGray
        self.statePickerView.setBottomSingleBorder(color: color)
    }
    
    fileprivate var stateStrings = ["Florida", "Cali", "NY", "BA"]
    private func initStatePickerView() {
        statePickerView.type = .strings
        statePickerView.pickerDelegate = self
        statePickerView.dataSource = self
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 3 {
            self.carDescriptionLabel.textColor = UIColor.black
        }
    }

//    func textViewDidEndEditing(_ textView: UITextView) {
//        carDescTextView.resignFirstResponder()
//    }
    
}


extension TellUsAboutYourCarViewController: APJTextPickerViewDelegate {
//    private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
//        print("Date Selected: \(date)")
//    }
    
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
        
//        else {
//            if self.modelLabel.text != "" {
//                self.modelLabel.textColor = UIColor.black
//                self.modelPickerView.setBottomSingleBorder(color: UIColor.black.cgColor)
//            }
//            return modelStrings[row]
//        }
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

