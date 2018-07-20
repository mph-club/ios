//
//  BookingWindowViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView


class BookingWindowViewController: UIViewController {
    
    @IBOutlet weak var windowPickerView: APJTextPickerView!
    @IBOutlet weak var nextButtton: nextButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIBarButtonItem(image: UIImage(named: "arrowLeft28Px"), style: .plain, target: self, action: #selector(BookingWindowViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        initWindowPickerView()
    }
    
    
    fileprivate var windowStrings = ["1 hour", "2 hours"]
    private func initWindowPickerView() {
        windowPickerView.type = .strings
        windowPickerView.pickerDelegate = self
        windowPickerView.dataSource = self
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToHowBookingWorks", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToBookingWindow(segue: UIStoryboardSegue) {}


}


extension BookingWindowViewController: APJTextPickerViewDelegate {
    private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
        print("Date Selected: \(date)")
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1 {
            print("Selected: \(windowStrings[row])")
            
            if windowStrings[row] != "" {
                checkAllSelected()
            }
            
        } else {
            
        }
        
    }
    
    func checkAllSelected() {
            nextButtton.backgroundColor = UIColor.black
    }
    

    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        if textPickerView.tag == 1 {
            return windowStrings[row]
        } else {
            return ""
        }
    }
}

extension BookingWindowViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        
        if pickerView.tag == 1 {
            if windowPickerView.text != "" {
                nextButtton.backgroundColor = UIColor.black
            }
            return windowStrings.count
        } else {
            return 0
        }
    }
}

