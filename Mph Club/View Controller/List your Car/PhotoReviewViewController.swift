//
//  PhotoReviewViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/20/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PhotoReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var retakeButton: UIButton!
    
    var typeOfPicker = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let radius = self.imageView.layer.frame.width/2.0
        self.imageView.layer.cornerRadius = radius
        self.imageView.layer.masksToBounds = true
       
        
        retakeButton.layer.borderWidth = 2
        retakeButton.layer.borderColor = UIColor.black.cgColor
        
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(RegisPhotoViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        takePhoto()
    }
    
    func takePhoto() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        if typeOfPicker == "library" {
            imagePicker.sourceType = .photoLibrary
        } else {
            imagePicker.sourceType = .camera
        }
        
        present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func retake(_ sender: UIButton) {
        let fireAction = fireActionSheet(title: "Select one", message: "")
        
        fireAction.addAction(UIAlertAction(title: "Choose from photo library", style: .default, handler: { action in
            self.typeOfPicker = "library"
            self.takePhoto()
        }))
        
        fireAction.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { action in
            self.typeOfPicker = "camera"
            self.takePhoto()
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(fireAction, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
            
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


//import UIKit
//
//class RegisPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
////    var imagePicker: UIImagePickerController!
////    @IBOutlet weak var imageView: UIImageView!
////    @IBOutlet weak var retakeButton: UIButton!
//
//
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        retakeButton.layer.borderWidth = 2
////        retakeButton.layer.borderColor = UIColor.black.cgColor
////
////        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(RegisPhotoViewController.close))
////        button1.tintColor = UIColor.black
////        self.navigationItem.leftBarButtonItem  = button1
////
////        takePhoto()
////    }
////
////    func takePhoto() {
////        imagePicker =  UIImagePickerController()
////        imagePicker.delegate = self
////        imagePicker.sourceType = .camera
////
////        present(imagePicker, animated: true, completion: nil)
////    }
////
////    @objc func close() {
////        dismiss(animated: true, completion: nil)
////    }
////
//
//    @IBAction func retake(_ sender: UIButton) {
//        takePhoto()
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        imagePicker.dismiss(animated: true, completion: nil)
//}
