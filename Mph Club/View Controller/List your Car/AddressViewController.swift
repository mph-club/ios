//
//  AddressViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/4/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var addressTextField: MphTextField!
    @IBOutlet var cityAndStateTextField: MphTextField!
    @IBOutlet var zipCodeTextField: MphTextField!
    @IBOutlet var placeTextField: MphTextField!
    
    @IBOutlet weak var cityAndStateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
        self.nextButton.backgroundColor = UIColor.lightGray
        setUpTextField(color: UIColor.lightGray.cgColor)
        
        self.cityAndStateLabel.textColor = UIColor.lightGray
        self.zipCodeLabel.textColor = UIColor.lightGray
        self.placesLabel.textColor = UIColor.lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addressTextField.isUserInteractionEnabled = true
    }
    
    func setUpTextField(color: CGColor) {
        self.cityAndStateTextField.setBottomSingleBorder(color: color)
        self.zipCodeTextField.setBottomSingleBorder(color: color)
        self.placeTextField.setBottomSingleBorder(color: color)
        
        self.cityAndStateLabel.textColor = UIColor.black
        self.zipCodeLabel.textColor = UIColor.black
        self.placesLabel.textColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.addressTextField.isUserInteractionEnabled = false
        performSegue(withIdentifier: "goToMap", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapvc = segue.destination as? MapViewController {
            print("segue")
            mapvc.addressDelegate = self
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let fireAction = fireActionSheet(title: "Before you close", message: "If you proceed with this action, you'll have to start from the beginning.")
        
        fireAction.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
           self.dismiss(animated: true, completion: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        
        self.present(fireAction, animated: true)
        
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func unwindToAddress(segue: UIStoryboardSegue) {}

}

extension AddressViewController: LocationSearchTableDelegate {
    func displayAddressSelected(_ locationDetail: Location) {
        
        self.nextButton.backgroundColor = UIColor.black
        setUpTextField(color: UIColor.black.cgColor)
        self.addressTextField.text = locationDetail.address
        
        guard let city = locationDetail.city else { return }
        guard let state = locationDetail.state else { return }
    
        self.cityAndStateTextField.text = "\(String(describing: city)), \(String(describing: state))"
        self.zipCodeTextField.text = locationDetail.zipCode
        
        if locationDetail.address != locationDetail.title {
            self.placeTextField.text = locationDetail.title
        } else {
            self.placeTextField.text = ""
        }
        
        print("Hit")
    }
    

}
