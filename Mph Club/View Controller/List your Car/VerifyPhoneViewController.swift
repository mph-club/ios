//
//  VerifyPhoneViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/16/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController {

    @IBOutlet weak var nextButton: nextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backToProgress(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToProgress", sender: nil)
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


extension VerifyPhoneViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nextButton.backgroundColor = UIColor.black
        print("Begin")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
         print("End")
    }
    
}
