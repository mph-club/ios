//
//  PriceContainerViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/25/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PriceContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navButton1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(PriceContainerViewController.close))
        navButton1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = navButton1
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTerms", sender: nil)
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
