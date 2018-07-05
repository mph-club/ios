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
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
        self.nextButton.backgroundColor = UIColor.lightGray
        setUpTextField(color: UIColor.lightGray.cgColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addressTextField.isUserInteractionEnabled = true
    }
    
    func setUpTextField(color: CGColor) {
        self.cityAndStateTextField.setBottomSingleBorder(color: color)
        self.zipCodeTextField.setBottomSingleBorder(color: color)
        self.placeTextField.setBottomSingleBorder(color: color)
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
    
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}


}

extension AddressViewController: LocationSearchTableDelegate {
    func displayAddressSelected(_ locationDetail: Location) {
        self.nextButton.backgroundColor = UIColor.black
        setUpTextField(color: UIColor.black.cgColor)
        self.addressTextField.text = locationDetail.address
        self.cityAndStateTextField.text = "\(String(describing: locationDetail.city!)), \(String(describing: locationDetail.state!))"
        self.zipCodeTextField.text = locationDetail.zipCode
        self.placeTextField.text = locationDetail.title
        print("Hit")
    }
    

}
