//
//  AddressViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/4/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class AddressViewController: UIViewController, UITextFieldDelegate {    
    // MARK: - Object to pass to next view controller
    var carLocation = [String: String]()
    
    
    @IBOutlet weak var addressTextField: MphTextField!
    @IBOutlet var cityAndStateTextField: MphTextField!
    @IBOutlet var zipCodeTextField: MphTextField!
    @IBOutlet var placeTextField: MphTextField!
    
    @IBOutlet weak var cityAndStateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    
    // Object sent over in segue
    var location: CLPlacemark?
    
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if location != nil {
            print(location)
            updateForm()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.addressTextField.isUserInteractionEnabled = true
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        if addressTextField.text != "" || cityAndStateTextField.text != "" || zipCodeTextField.text != "" || placeTextField.text != "" {
            carLocation["address"] = addressTextField.text
            carLocation["city"] = location?.postalAddress?.city
            carLocation["state"] = location?.postalAddress?.state
            carLocation["zipCode"] = zipCodeTextField.text
            carLocation["place"] = placeTextField.text
        }
        performSegue(withIdentifier: "goToEnterCar", sender: nil)
    }
    
    
    func updateForm() {
        self.nextButton.backgroundColor = UIColor.black
        setUpTextField(color: UIColor.black.cgColor)

        self.addressTextField.text = location?.postalAddress?.street
        
        guard let city = location?.locality else { return }
        guard let state = location?.administrativeArea else { return }
        
        self.cityAndStateTextField.text = "\(String(describing: city)), \(String(describing: state))"
        self.zipCodeTextField.text = location?.postalCode
        
        if location?.postalAddress?.street != location?.name {
            self.placeTextField.text = location?.name
        } else {
            self.placeTextField.text = ""
        }

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
        performSegue(withIdentifier: "goToSearchTable", sender: nil)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carEligibilityViewController = segue.destination as? CarEligibilityViewController {
            carEligibilityViewController.location = carLocation
        }
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    @IBAction func unwindToAddress(segue: UIStoryboardSegue) {}

}

// Was used in prior setup
//extension AddressViewController: LocationSearchTableDelegate {
//    func displayAddressSelected(_ locationDetail: Location) {
//
//        self.nextButton.backgroundColor = UIColor.black
//        setUpTextField(color: UIColor.black.cgColor)
//        self.addressTextField.text = locationDetail.address
//
//        guard let city = locationDetail.city else { return }
//        guard let state = locationDetail.state else { return }
//
//        self.cityAndStateTextField.text = "\(String(describing: city)), \(String(describing: state))"
//        self.zipCodeTextField.text = locationDetail.zipCode
//
//        if locationDetail.address != locationDetail.title {
//            self.placeTextField.text = locationDetail.title
//        } else {
//            self.placeTextField.text = ""
//        }
//
//        print("Hit")
//    }

//}
