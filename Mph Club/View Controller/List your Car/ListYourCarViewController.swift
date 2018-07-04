//
//  ListYourCarViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/4/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class ListYourCarViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var addressTextField: MphTextField!
    @IBOutlet var cityAndStateTextField: MphTextField!
    @IBOutlet var zipCodeTextField: MphTextField!
    @IBOutlet var placeTextField: MphTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
        
//        print("segue")
//        let mapvc = MapViewController()
//        mapvc.addressDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addressTextField.isUserInteractionEnabled = true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListYourCarViewController: LocationSearchTableDelegate {
    func displayAddressSelected(_ locationDetail: LocationDetail) {
        self.addressTextField.text = locationDetail.address
        self.cityAndStateTextField.text = "\(locationDetail.city), \(locationDetail.state)"
        self.zipCodeTextField.text = locationDetail.zipCode
        self.placeTextField.text = locationDetail.title
        print("Hit")
    }
    

}
