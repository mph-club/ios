//
//  TakeRegistrationPicViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/18/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class TakeRegistrationPicViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(PhotoViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
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
            self.performSegue(withIdentifier: "regisPhotoView", sender: "library")
        }))
        
        fireAction.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { action in
            self.performSegue(withIdentifier: "regisPhotoView", sender: "camera")
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(fireAction, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "regisPhotoView" {
            if let destinationVC = segue.destination as? RegisPhotoViewController {
                if sender as! String == "library" {
                    destinationVC.typeOfPicker = "library"
                } else {
                    destinationVC.typeOfPicker = "camera"
                }
                
            }
        }
    }

}
