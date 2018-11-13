//
//  CarEligibilityViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

protocol ChangeButtonColorDelegate: class {
    func setColor(color: UIColor)
}

final class TellUsAboutYourCarViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showAddPhoto
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: View
    @IBOutlet private weak var contentView: UIView!
    
    // MARK: Text View
    @IBOutlet private weak var carDescTextView: UITextView!
    
    // MARK: Button
    @IBOutlet private weak var nextButtton: UIButton!
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Delegate
    weak var delegate: ChangeButtonColorDelegate?
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension TellUsAboutYourCarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        carDescTextView.delegate = self
        //
        carDescTextView.layer.borderWidth = 1
        carDescTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
}

// ===============
// MARK: - Actions
// ===============
private extension TellUsAboutYourCarViewController {
    @IBAction func nextPressed(_ sender: UIButton) {
        if !carDescTextView.text.isEmpty {
            showLoading()
                .then(updateListCar)
                .done(showNextPage)
                .ensure(hideLoading)
                .catch(presentError)
        }
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        let fireAction = fireActionSheet(title: "Before you close",
                                         message: "If you proceed with this action, you'll have to start from the beginning.")
        
        fireAction.addAction(UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        })
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(fireAction, animated: true)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension TellUsAboutYourCarViewController {
    func showNextPage() {
        self.performSegue(withIdentifier: Segue.showAddPhoto)
    }
    
    func setBottomBorder() {
        navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    func removeBottomBorder() {
        navigationController?.navigationBar.layer.backgroundColor = UIColor.white.cgColor
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    func normalState() {
        if !carDescTextView.text.isEmpty {
            // turn btn black
            delegate?.setColor(color: UIColor.black)
        }
    }
}

// ==========================
// MARK: - Facade Interaction
// ==========================
private extension TellUsAboutYourCarViewController {
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
                                             viewIndex: 3,
                                             id: Constant.carKey)
        return ListYourCarFacade.shared.addOwnCar(parameters)
            .asVoid()
    }
}

// ==========================
// MARK: - View State Manager
// ==========================
private extension TellUsAboutYourCarViewController {
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

// =================
// MARK: - Text View
// =================

// MARK: Delegate
extension TellUsAboutYourCarViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.tag == 3 {
            carDescTextView.text = textView.text
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 3 {
            carDescTextView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        normalState()
        
        return true
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension TellUsAboutYourCarViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setBottomBorder()
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            print("reach bottom")
        }
        
        if scrollView.contentOffset.y <= 0 {
            print("reach top")
            removeBottomBorder()
        }
    }
}
