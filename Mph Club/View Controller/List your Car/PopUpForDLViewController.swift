//
//  PopUpForDLViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import APJTextPickerView

class PopUpForDLViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
