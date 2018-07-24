//
//  AddPriceViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AddPriceViewController: UIViewController {

    @IBOutlet weak var fixedPriceTextField: MphTextField!
    @IBOutlet weak var recommendedPriceLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.setImage(UIImage(named : "group7"), for: UIControlState.normal)
        button2.setImage(UIImage(named : "group7-1"), for: UIControlState.normal)
        fixedPriceTextField.setBottomSingleBorder(color: UIColor.lightGray.cgColor)
        
        let navButton1 = UIBarButtonItem(image: UIImage(named: "arrowLeft28Px"), style: .plain, target: self, action: #selector(AddPriceViewController.close))
        navButton1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = navButton1
        
        self.fixedPriceTextField.keyboardType = UIKeyboardType.decimalPad
        
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
