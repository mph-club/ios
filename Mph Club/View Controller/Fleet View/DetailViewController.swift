//
//  DetailViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    var newBackButton = UIBarButtonItem()
    
    @IBOutlet weak var scrollView: UIScrollView!
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
        newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > 1 {
            offset = 1
            let color = UIColor.black
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarView?.backgroundColor = color
        } else {
            let color = UIColor.clear
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarView?.backgroundColor = color
        }
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToFleet", sender: nil)
    }
    



}


extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

