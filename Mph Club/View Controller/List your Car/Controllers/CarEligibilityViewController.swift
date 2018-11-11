//
//  CarEligibilityViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit
import APJTextPickerView

final class CarEligibilityViewController: UIViewController, UIScrollViewDelegate {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: View
    @IBOutlet weak var contentView: UIView!
    
    // MARK: Picker View
    @IBOutlet private weak var yearPickerView: APJTextPickerView!
    
    // MARK: Text Field
    @IBOutlet private weak var makeTextField: MphTextField!
    @IBOutlet private weak var modelTextField: MphTextField!
    @IBOutlet private weak var odemeterTextField: MphTextField!
    @IBOutlet private weak var transmissionTextField: MphTextField!
    
    // MARK: Button
    @IBOutlet private weak var nextButtton: NextButton!
    
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
    private var yearStrings = ["2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011"]
    private var transmissionItem = ["AUTO", "MANUAL"]
    
    // MARK: Passing Object
    var location = [String: String]()
    
    // MARK: Lazy Var
    private lazy var transmissionPickerView: UIPickerView = {
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
        //
        initYearPickerView()
        //
        setUpTextField(color: UIColor.lightGray.cgColor)
        //
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrowLeft28Px"), style: .done, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem?.tintColor = .black
        // Observe keyboard change
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        // add tap gesture for dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDidFire))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    func updateListCar() -> Promise<Void> {
        let parameters = AddOwnCarParameters(make: makeTextField.text,
                                             model: modelTextField.text,
                                             year: Int(yearPickerView.text ?? "-1"),
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
    @IBAction func nextButton(_ sender: NextButton) {
        if yearPickerView.text != "" && self.makeTextField.text != "" && self.modelTextField.text != "" && self.odemeterTextField.text != "" && self.transmissionTextField.text != "" {
            showLoading()
                .then(updateListCar)
                .done(showNextPage)
                .ensure(hideLoading)
                .catch(presentError)
        }
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
    
    func initYearPickerView() {
        yearPickerView.type = .strings
        yearPickerView.pickerDelegate = self
        yearPickerView.dataSource = self
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


// MARK: Keyboard Handling
extension CarEligibilityViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.checkTextField()
        //
        let contentInsets: UIEdgeInsets = .zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    func checkTextField() {
        
        if makeTextField.text != "" {
            makeLabel.textColor = UIColor.black
        }
        
        if modelTextField.text != "" {
            modelLabel.textColor = UIColor.black
        }
        
        if odemeterTextField.text != "" {
            odemeterLabel.textColor = UIColor.black
        }
        
        if transmissionTextField.text != "" {
            transmissionLabel.textColor = UIColor.black
        }
    }
}



// ===========================
// MARK: - APJText Picker View
// ===========================

// MARK: Data Source
extension CarEligibilityViewController: APJTextPickerViewDataSource {
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        return yearStrings.count
    }
}

// MARK: Delegate
extension CarEligibilityViewController: APJTextPickerViewDelegate {
    
    private func textPickerView(_ textPickerView: APJTextPickerView, didSelectDate date: Date) {
        print("Date Selected: \(date)")
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        if textPickerView.tag == 1 {
            print("Selected: \(yearStrings[row])")
            yearPickerView.text = yearStrings[row]
        }
        
        checkAllSelected()
    }
    
    func checkAllSelected() {
        if yearPickerView.text != "" && makeTextField.text != "" && modelTextField.text != "" {
            nextButtton.backgroundColor = UIColor.black
        }
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        return yearStrings[row]
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
        return transmissionItem[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return transmissionItem.count
    }
}

// MARK: Delegate
extension CarEligibilityViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        transmissionTextField.text = transmissionItem[row]
    }
}


// ===================
// MARK: - Scroll View
// ===================
extension CarEligibilityViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setBottomBorder()
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            print("reach bottom")
        }
        
        if (scrollView.contentOffset.y <= 0){
            print("reach top")
            self.removeBottomBorder()
        }
        
        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)) {
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
