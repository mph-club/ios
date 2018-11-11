//
//  CarPhotoViewViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/19/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

class CarPhotoViewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    var typeOfPicker = ""
    
    //   @IBOutlet weak var retakeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        retakeButton.layer.borderWidth = 2
        //        retakeButton.layer.borderColor = UIColor.black.cgColor
        
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(CarPhotoViewViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        if typeOfPicker == "library" {
            imagePicker.sourceType = .photoLibrary
        } else {
            imagePicker.sourceType = .camera
        }
        present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    func takePhoto() {
        let fireAction = fireActionSheet(title: "Select one", message: "")
        
        fireAction.addAction(UIAlertAction(title: "Choose from photo library", style: .default, handler: { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { action in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(fireAction, animated: true)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if image2Bool == true {
            image2.image = info[.originalImage] as? UIImage
            image2Bool = false
            uploadProfileImage(image2)
        } else if image3Bool == true {
            image3.image = info[.originalImage] as? UIImage
            image3Bool = false
            uploadProfileImage(image3)
        } else if image4Bool == true {
            image4.image = info[.originalImage] as? UIImage
            image4Bool = false
            uploadProfileImage(image4)
        } else if image5Bool == true {
            image5.image = info[.originalImage] as? UIImage
            image5Bool = false
            uploadProfileImage(image5)
        } else {
            imageView.image = info[.originalImage] as? UIImage
            imageCoverBool = false
            uploadProfileImage(imageView)
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

// ===============
// MARK: - Methods
// ===============
private extension CarPhotoViewViewController {
    func uploadProfileImage(_ imageView: UIImageView) {
        
        guard let image = imageView.image else { return }
        
        
        showLoading(imageView)
            .then { _ in image.compress(toSize: 2048) }
            .then(addCarImage)
            .then(updateListCar)
            .ensure { [weak self] in self?.hideLoading(imageView) }
            .catch(presentError)
    }
    
    
    func addCarImage(fileData: Data) -> Promise<Void> {
        let imageUploadFile = ImageUploadFileModel(key: "photo",
                                                   value: fileData,
                                                   name: UUID().uuidString,
                                                   extension: ".jpg",
                                                   mimeType: "image/jpeg")
        //
        let parameters = UploadCarImageParameters(vehicle: Constant.carKey)
        //
        return ListYourCarFacade.shared
            .uploadCarImage(imageUploadFile, parameters: parameters)
    }
    
    func updateListCar() -> Promise<Void> {
        let parameters = AddOwnCarParameters(make: nil,
                                             model: nil,
                                             year: nil,
                                             miles: nil,
                                             transmission: nil,
                                             address: nil,
                                             city: nil,
                                             state: nil,
                                             zipCode: nil,
                                             place: nil,
                                             viewIndex: 4,
                                             id: Constant.carKey)
        return ListYourCarFacade.shared.addOwnCar(parameters)
            .asVoid()
    }
}

// ==========================
// MARK: - View State Manager
// ==========================
private extension CarPhotoViewViewController {
    func showLoading(_ imageView: UIImageView) -> Guarantee<Void> {
        imageView.showLoading()
        return Guarantee.value(())
    }
    
    func hideLoading(_ imageView: UIImageView) {
        imageView.hideLoading()
    }
}
