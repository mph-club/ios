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

final class AddressViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showSearchLocation
        case showEnterCar
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Text Field
    @IBOutlet private weak var addressTextField: MphTextField!
    @IBOutlet private weak var cityAndStateTextField: MphTextField!
    @IBOutlet private weak var placeTextField: MphTextField!
    
    // MARK: Label
    @IBOutlet private weak var cityAndStateLabel: UILabel!
    @IBOutlet private weak var placesLabel: UILabel!
    
    // MARK: Button
    @IBOutlet private weak var nextButton: UIButton!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Object sent over in segue
    var location: CLPlacemark?
    
    // MARK: Object to pass to next view controller
    private var carLocation = [String: String]()
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension AddressViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nextButton.backgroundColor = UIColor.lightGray
        setUpTextField(color: UIColor.lightGray.cgColor)
        
        cityAndStateLabel.textColor = UIColor.lightGray
        placesLabel.textColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if location != nil {
            updateForm()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addressTextField.isUserInteractionEnabled = true
    }
}

// MARK: Navigation
extension AddressViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = Segue(rawValue: segue.identifier ?? "") else { return }
        //
        switch identifier {
        case .showEnterCar:
            let carEligibilityVC = segue.destination as? CarEligibilityViewController
            carEligibilityVC?.location = carLocation
        case .showSearchLocation:
            let searchLocationVC = segue.destination as? BookingSearchLoacationViewController
            searchLocationVC?.isOwnCar = true
        }
    }
}

// ===============
// MARK: - Actions
// ===============
private extension AddressViewController {
    @IBAction func nextButton(_ sender: UIButton) {
        if !(addressTextField.text?.isEmpty ?? true) ||
            !(cityAndStateTextField.text?.isEmpty ?? true) ||
            !(placeTextField.text?.isEmpty ?? true) {
            carLocation["address"] = addressTextField.text
            carLocation["city"] = location?.postalAddress?.city
            carLocation["state"] = location?.postalAddress?.state
            carLocation["place"] = placeTextField.text
        }
        performSegue(withIdentifier: Segue.showEnterCar)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let fireAction = fireActionSheet(title: "Before you close",
                                         message: "If you proceed with this action, you'll have to start from the beginning.")
        
        fireAction.addAction(UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        })
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(fireAction, animated: true)
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    @IBAction func unwindToAddress(segue: UIStoryboardSegue) {}
}

// ===============
// MARK: - Methods
// ===============
private extension AddressViewController {
    func updateForm() {
        nextButton.backgroundColor = UIColor.black
        setUpTextField(color: UIColor.black.cgColor)
        
        addressTextField.text = location?.postalAddress?.street
        
        guard let city = location?.locality else { return }
        guard let state = location?.administrativeArea else { return }
        
        cityAndStateTextField.text = "\(String(describing: city)), \(String(describing: state))"
        
        if location?.postalAddress?.street != location?.name {
            self.placeTextField.text = location?.name
        } else {
            self.placeTextField.text = ""
        }
    }
    
    func setUpTextField(color: CGColor) {
        cityAndStateTextField.setBottomSingleBorder(color: color)
        placeTextField.setBottomSingleBorder(color: color)
        
        cityAndStateLabel.textColor = UIColor.black
        placesLabel.textColor = UIColor.black
    }
}

// ==================
// MARK: - Text Field
// ==================

// MARK: Delegate
extension AddressViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addressTextField.isUserInteractionEnabled = false
        performSegue(withIdentifier: Segue.showSearchLocation)
    }
}
