//
//  AddAPhotoOfCarViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/19/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AddAPhotoOfCarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImg: UIImage = UIImage(named: Constant.closeIcon)!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(AddAPhotoOfCarViewController.close))
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
            self.performSegue(withIdentifier: "carPhotoView", sender: "library")
        }))
        
        fireAction.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { action in
            self.performSegue(withIdentifier: "carPhotoView", sender: "camera")
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(fireAction, animated: true)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "carPhotoView" {
            if let destinationVC = segue.destination as? CarPhotoViewViewController {
                if sender as! String == "library" {
                    destinationVC.typeOfPicker = "library"
                } else {
                    destinationVC.typeOfPicker = "camera"
                }
                
            }
        }
    }

}
