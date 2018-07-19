//
//  CarPhotoViewViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/19/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class CarPhotoViewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    
    
 //   @IBOutlet weak var retakeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        retakeButton.layer.borderWidth = 2
//        retakeButton.layer.borderColor = UIColor.black.cgColor
        
        let button1 = UIBarButtonItem(image: UIImage(named: "arrowLeft28Px"), style: .plain, target: self, action: #selector(CarPhotoViewViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        takePhoto()
    }
    
    func takePhoto() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    var imageCoverBool = false
    @IBAction func tappedCover(_ sender: UITapGestureRecognizer) {
        imageCoverBool = true
        takePhoto()
    }
    
    
    var image2Bool = false
    @IBAction func tapped2ndImage(_ sender: UITapGestureRecognizer) {
        image2Bool = true
        takePhoto()
    }
    
    var image3Bool = false
    @IBAction func tapped3rdImage(_ sender: UITapGestureRecognizer) {
        image3Bool = true
        takePhoto()
    }
    
    var image4Bool = false
    @IBAction func tapped4Image(_ sender: UITapGestureRecognizer) {
        image4Bool = true
        takePhoto()
    }
    
    var image5Bool = false
    @IBAction func tapped5Image(_ sender: UITapGestureRecognizer) {
        image5Bool = true
        takePhoto()
    }
    
    
//    @IBAction func retake(_ sender: UIButton) {
//        takePhoto()
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if image2Bool == true {
            image2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            image2Bool = false
        } else if image3Bool == true {
            image3.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            image3Bool = false
        } else if image4Bool == true {
            image4.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            image4Bool = false
        } else if image5Bool == true {
            image5.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            image5Bool = false
        } else {
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageCoverBool = false
        }
        
        
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
