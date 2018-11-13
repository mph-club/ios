//
//  CarEligibilityViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

final class CarEligibilityViewController: UIViewController, UIScrollViewDelegate {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Scroll View
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: View
    @IBOutlet private weak var contentView: UIView!
    
    // MARK: Text Field
    @IBOutlet private weak var yearTextField: MphTextField!
    @IBOutlet private weak var makeTextField: MphTextField!
    @IBOutlet private weak var modelTextField: MphTextField!
    @IBOutlet private weak var odemeterTextField: MphTextField!
    @IBOutlet private weak var transmissionTextField: MphTextField!
    
    // MARK: Button
    @IBOutlet private weak var nextButtton: UIButton!
    
    // MARK: Label
    @IBOutlet private weak var makeLabel: UILabel!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var odemeterLabel: UILabel!
    @IBOutlet private weak var transmissionLabel: UILabel!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var activeField: UITextField?
    private var yearItems = ["2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011"]
    private var transmissionItems = ["AUTO", "MANUAL"]
    
    // MARK: Passing Object
    var location = [String: String]()
    
    // MARK: Lazy Var
    private lazy var transmissionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        return pickerView
    }()
    //
    private lazy var yearsPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        return pickerView
    }()
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension CarEligibilityViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        transmissionTextField.inputView = transmissionPickerView
        yearTextField.inputView = yearsPickerView
        //
        setUpTextField(color: UIColor.lightGray.cgColor)
    }
    
    func updateListCar() -> Promise<Void> {
        let parameters = AddOwnCarParameters(make: makeTextField.text,
                                             model: modelTextField.text,
                                             year: Int(yearTextField.text ?? "-1"),
                                             miles: Int(odemeterTextField.text ?? "-1"),
                                             transmission: transmissionTextField.text,
                                             address: location["address"],
                                             city: location["city"],
                                             state: location["state"],
                                             zipCode: location["zipcode"],
                                             place: location["place"],
                                             viewIndex: 1,
                                             id: nil)
        
        return ListYourCarFacade.shared.addOwnCar(parameters)
            .get(setOwnCarID)
            .asVoid()
    }
}

// ===============
// MARK: - Actions
// ===============
private extension CarEligibilityViewController {
    @IBAction func nextTouchUpInside(_ sender: UIButton) {
        if !(yearTextField.text?.isEmpty ?? true) &&
            !(makeTextField.text?.isEmpty ?? true) &&
            !(modelTextField.text?.isEmpty ?? true) &&
            !(odemeterTextField.text?.isEmpty ?? true) &&
            !(transmissionTextField.text?.isEmpty ?? true) {
            showLoading()
                .then(updateListCar)
                .done(showNextPage)
                .ensure(hideLoading)
                .catch(presentError)
        }
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension CarEligibilityViewController {
    func setUpTextField(color: CGColor) {
        self.makeLabel.textColor = UIColor.lightGray
        self.modelLabel.textColor = UIColor.lightGray
        self.odemeterLabel.textColor = UIColor.lightGray
        self.transmissionLabel.textColor = UIColor.lightGray
        
    }
    
    func checkTextField() {
        if !(makeTextField.text?.isEmpty ?? true) {
            makeLabel.textColor = UIColor.black
        }
        
        if !(modelTextField.text?.isEmpty ?? true) {
            modelLabel.textColor = UIColor.black
        }
        
        if !(odemeterTextField.text?.isEmpty ?? true) {
            odemeterLabel.textColor = UIColor.black
        }
        
        if !(transmissionTextField.text?.isEmpty ?? true) {
            transmissionLabel.textColor = UIColor.black
        }
    }
    
    func checkAllSelected() {
        if !(yearTextField.text?.isEmpty ?? true) &&
            !(makeTextField.text?.isEmpty ?? true) &&
            !(modelTextField.text?.isEmpty ?? true) {
            nextButtton.backgroundColor = UIColor.black
        }
    }
    
    func setOwnCarID(_ result: ParentAddOwnCarResult) {
        Constant.carKey = result.data.id
    }
    
    func showNextPage() {
        performSegue(withIdentifier: "goToProgressVC", sender: nil)
    }
    
    @objc func close() {
        performSegue(withIdentifier: "unwindToAddress", sender: nil)
    }
    
    @objc func tapGestureDidFire() {
        scrollView.endEditing(true)
    }
}

// ==========================
// MARK: - View State Manager
// ==========================
private extension CarEligibilityViewController {
    func showLoading() -> Guarantee<Void> {
        nextButtton.isEnabled = false
        nextButtton.showLoading()
        return Guarantee.value(())
    }
    
    func hideLoading() {
        nextButtton.isEnabled = true
        nextButtton.hideLoading()
    }
}

// ==================
// MARK: - Text Field
// ==================

// MARK: Delegate
extension CarEligibilityViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkTextField()
    }
}

// ===================
// MARK: - Picker View
// ===================

// MARK: Data Source
extension CarEligibilityViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case transmissionPickerView:
            return transmissionItems[row]
        case yearsPickerView:
            return yearItems[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case transmissionPickerView:
            return transmissionItems.count
        case yearsPickerView:
            return yearItems.count
        default:
            return 0
        }
    }
}

// MARK: Delegate
extension CarEligibilityViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case transmissionPickerView:
            transmissionTextField.text = transmissionItems[row]
        case yearsPickerView:
            yearTextField.text = yearItems[row]
            checkAllSelected()
        default:
            break
        }
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension CarEligibilityViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setBottomBorder()
        
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            print("reach bottom")
        }
        
        if scrollView.contentOffset.y <= 0 {
            print("reach top")
            self.removeBottomBorder()
        }
        
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height) {
            // not top and not bottom
        }
    }
    
    func setBottomBorder() {
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    func removeBottomBorder() {
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
}
