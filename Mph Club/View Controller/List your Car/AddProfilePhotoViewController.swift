//
//  AddProfilePhotoViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/19/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AddProfilePhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImg: UIImage = UIImage(named: "close28Px")!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(AddProfilePhotoViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        let fireAction = fireActionSheet(title: "Select one", message: "")
        
        fireAction.addAction(UIAlertAction(title: "Choose from photo library", style: .default, handler: { action in
            
        }))
        
        fireAction.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { action in
            self.performSegue(withIdentifier: "addSelfie", sender: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
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