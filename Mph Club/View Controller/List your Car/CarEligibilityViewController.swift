//
//  CarEligibilityViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView

class CarEligibilityViewController: UIViewController {

    @IBOutlet weak var yearPickerView: APJTextPickerView!
    @IBOutlet weak var makePickerView: APJTextPickerView!
    @IBOutlet weak var modelPickerView: APJTextPickerView!
    
    @IBOutlet weak var nextButtton: nextButton!
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initYearPickerView()
        initMakePickerView()
        initModelPickerView()
        
        setUpTextField(color: UIColor.lightGray.cgColor)
        
        let backImg: UIImage = UIImage(named: "arrowLeft28Px")!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(CarEligibilityViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func close() {
        self.performSegue(withIdentifier: "unwindToAddress", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func setUpTextField(color: CGColor) {
        self.makeLabel.textColor = UIColor.lightGray
        self.modelLabel.textColor = UIColor.lightGray
        self.makePickerView.setBottomSingleBorder(color: color)
        self.modelPickerView.setBottomSingleBorder(color: color)
    }
    
    fileprivate var yearStrings = ["2018", "2017", "2016", "2015"]
    private func initYearPickerView() {
        yearPickerView.type = .strings
        yearPickerView.pickerDelegate = self
        yearPickerView.dataSource = self
    }
    
    fileprivate var makeStrings = ["BMW", "LAMBO"]
    private func initMakePickerView() {
        makePickerView.type = .strings
        makePickerView.pickerDelegate = self
        makePickerView.dataSource = self
    }

    fileprivate var modelStrings = ["A1", "A2", "A3"]
    private func initModelPickerView() {
        modelPickerView.type = .strings
        modelPickerView.pickerDelegate = self
        modelPickerView.dataSource = self
    }

    
    

}


extension CarEligibilityViewController: APJTextPickerViewDelegate {
    private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
        print("Date Selected: \(date)")
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1 {
            print("Selected: \(yearStrings[row])")
        } else if textPickerView.tag == 2 {
            print("Selected: \(makeStrings[row])")
        } else {
            checkAllSelected()
            print("Selected: \(modelStrings[row])")
        }
        
    }
    
    func checkAllSelected() {
        if yearPickerView.text != "" && makePickerView.text != "" {
            nextButtton.backgroundColor = UIColor.black
        }
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        if textPickerView.tag == 1 {
            return yearStrings[row]
        } else if textPickerView.tag == 2 {
            if self.makeLabel.text != "" {
                self.makeLabel.textColor = UIColor.black
                self.makePickerView.setBottomSingleBorder(color: UIColor.black.cgColor)
            }
            return makeStrings[row]
        } else {
            if self.modelLabel.text != "" {
                self.modelLabel.textColor = UIColor.black
                self.modelPickerView.setBottomSingleBorder(color: UIColor.black.cgColor)
            }
            return modelStrings[row]
        }
    }
}

extension CarEligibilityViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        
        if pickerView.tag == 1 {
            return yearStrings.count
        } else if pickerView.tag == 2 {
            return makeStrings.count
        } else {
            return modelStrings.count
        }
    }
}
