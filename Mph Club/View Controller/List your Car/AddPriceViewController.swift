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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIBarButtonItem(image: UIImage(named: "arrowLeft28Px"), style: .plain, target: self, action: #selector(AddPriceViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        self.fixedPriceTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToSetPriceView", sender: nil)
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
