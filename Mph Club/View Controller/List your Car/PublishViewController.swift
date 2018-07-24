//
//  PublishViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/23/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {

    @IBOutlet weak var saveForLaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // border to button
        saveForLaterButton.layer.borderWidth = 2
        saveForLaterButton.layer.borderColor = UIColor.black.cgColor
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
