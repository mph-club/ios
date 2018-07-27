//
//  TripLengthViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView

class TripLengthViewController: UIViewController {

    @IBOutlet weak var shortTripPickerView: APJTextPickerView!
    @IBOutlet weak var longTripPickerView: APJTextPickerView!
    @IBOutlet weak var nextButtton: nextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         initShortTripPickerView()
         initlLongTripPickerView()
        
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.backArrowIcon), style: .plain, target: self, action: #selector(BookingWindowViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
    }
    
    fileprivate var shortTripStrings = ["1 hour", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours", "7 hours", "8 hours"]
    private func initShortTripPickerView() {
        shortTripPickerView.type = .strings
        shortTripPickerView.pickerDelegate = self
        shortTripPickerView.dataSource = self
    }
    
    fileprivate var longTripStrings = ["1 hour", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours", "7 hours", "8 hours"]
    private func initlLongTripPickerView() {
        longTripPickerView.type = .strings
        longTripPickerView.pickerDelegate = self
        longTripPickerView.dataSource = self
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToBookingWindow", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension TripLengthViewController: APJTextPickerViewDelegate {
    private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
        print("Date Selected: \(date)")
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1 {
            print("Selected: \(shortTripStrings[row])")
            
            if shortTripStrings[row] != "" {
                checkAllSelected()
            }
            
        } else if textPickerView.tag == 2 {
            print("Selected: \(longTripStrings[row])")
            
            if longTripStrings[row] != "" {
                checkAllSelected()
            }
            
        }
        
    }
    
    func checkAllSelected() {
        nextButtton.backgroundColor = UIColor.black
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        if textPickerView.tag == 1 {
            return shortTripStrings[row]
        } else if textPickerView.tag == 2 {
            return longTripStrings[row]
        } else {
            return ""
        }
    }
}

extension TripLengthViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        if pickerView.tag == 1 {
            return shortTripStrings.count
        } else if pickerView.tag == 2 {
            return longTripStrings.count
        } else {
            return 0
        }
    }
}

/*
 

 
 
 
 extension BookingWindowViewController: APJTextPickerViewDelegate {
 private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
 print("Date Selected: \(date)")
 }
 
 func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
 if textPickerView.tag == 1 {
 print("Selected: \(windowStrings[row])")
 }
 
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
 return windowStrings.count
 } else {
 return 0
 }
 }
 }
 
 */
