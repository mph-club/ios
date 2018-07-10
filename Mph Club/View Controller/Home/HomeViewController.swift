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
    //    hideLeftBarButton()



    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      //  hideLeftBarButton()
    self.tabBarController?.navigationItem.hidesBackButton = true
    self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     //   self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func hideLeftBarButton() {
      //  self.tabBarController?.navigationItem.leftBarButtonItem?.disab
      //  self.tabBarController?.navigationItem.hidesBackButton = true
      //  self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        
//        self.tabBarController?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.tabBarController?.navigationController?.navigationBar.shadowImage = UIImage()
//        self.tabBarController?.navigationController?.navigationBar.isTranslucent = false
//        self.tabBarController?.navigationController?.view.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        self.tabBarController?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.tabBarController?.navigationController?.navigationBar.shadowImage = UIImage()
//        self.tabBarController?.navigationController?.navigationBar.isTranslucent = false
//        self.tabBarController?.navigationController?.view.backgroundColor = UIColor.black
    }
    
    
    @IBAction func goToFleet(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFleet", sender: nil)
    }
    
//    @IBAction func goToMap(_ sender: UIButton) {
//        performSegue(withIdentifier: "goToMap", sender: nil)
//    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
