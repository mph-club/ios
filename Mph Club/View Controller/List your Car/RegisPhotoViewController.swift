//
//  RegisPhotoViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/18/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class RegisPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var retakeButton: UIButton!
    
    var typeOfPicker = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retakeButton.layer.borderWidth = 2
        retakeButton.layer.borderColor = UIColor.black.cgColor
        
        let button1 = UIBarButtonItem(image: UIImage(named: "close28Px"), style: .plain, target: self, action: #selector(RegisPhotoViewController.close))
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
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func retake(_ sender: UIButton) {
        takePhoto()
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
