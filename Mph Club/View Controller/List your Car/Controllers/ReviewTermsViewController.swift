//
//  ReviewTermsViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/23/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class ReviewTermsViewController: UIViewController {

    @IBOutlet weak var declineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navButton1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(ReviewTermsViewController.close))
        navButton1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = navButton1
        
        // border to button
        declineButton.layer.borderWidth = 2
        declineButton.layer.borderColor = UIColor.black.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func close() {
        let fireAction = fireActionSheet(title: "Before you close", message: "If you proceed with this action, you'll have to start from the beginning.")
        
        fireAction.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        
        self.present(fireAction, animated: true)
    }
    
    @IBAction func decline(_ sender: UIButton) {
        let fireAction = fireActionSheet(title: "Before you close", message: "If you proceed with this action, you'll have to start from the beginning.")
        
        fireAction.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        
        self.present(fireAction, animated: true)
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
