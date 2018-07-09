//
//  HomeViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideLeftBarButton()



    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideLeftBarButton()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        hideLeftBarButton()
    }
    
    func hideLeftBarButton() {
      //  self.tabBarController?.navigationItem.leftBarButtonItem?.disab
        self.tabBarController?.navigationItem.hidesBackButton = true
      //  self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.black
    }
    
    
    @IBAction func goToFleet(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFleet", sender: nil)
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
