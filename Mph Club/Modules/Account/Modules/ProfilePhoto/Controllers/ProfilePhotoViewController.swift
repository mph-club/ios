//
//  ProfilePhotoViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ProfilePhotoViewController: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Image View
    @IBOutlet private weak var profileImageView: UIImageView!
    
    // MARK: Button
    @IBOutlet private weak var retakeButton: UIButton!
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ProfilePhotoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ProfilePhotoViewController {
    @IBAction func addAPhotoTouchUpInside(_ sender: UIButton) {
        let actionSheet = fireActionSheet(title: nil, message: nil)
        //
        let library = UIAlertAction(title: "Choose from photo library", style: .default, handler: showPhotoLibrary)
        let camera = UIAlertAction(title: "Take a photo", style: .default, handler: showCamera)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //
        actionSheet.addActions([library, camera, cancel])
        //
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func retakeTouchUpInside(_ sender: UIButton) {
        let actionSheet = fireActionSheet(title: nil, message: nil)
        //
        let library = UIAlertAction(title: "Choose from photo library", style: .default, handler: showPhotoLibrary)
        let camera = UIAlertAction(title: "Take a photo", style: .default, handler: showCamera)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //
        actionSheet.addActions([library, camera, cancel])
        //
        present(actionSheet, animated: true, completion: nil)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension ProfilePhotoViewController {
    func showPhotoLibrary(_ alertAction: UIAlertAction) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    func showCamera(_ alertAction: UIAlertAction) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("can't open camera")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
}

// ========================================================================
// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
// ========================================================================
extension ProfilePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        defer {
            dismiss(animated: true, completion: nil)
        }
        //
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImageView.image = image
        //
        retakeButton.isHidden = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            dismiss(animated: true, completion: nil)
        }
    }
}
