//
//  SetPriceViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class SetPriceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(SetPriceViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        
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
