//
//  ProgressViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

final class ProgressViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showTellUs
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Button
    @IBOutlet private weak var continueButton: UIButton!
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ProgressViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ProgressViewController {
    @IBAction func continueTouchUpInsideAction(_ sender: UIButton) {
        showLoading()
            .then(updateListCar)
            .done(showNextPage)
            .ensure(hideLoading)
            .catch(presentError)
        
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
    
    @IBAction func unwindToCheckList(segue: UIStoryboardSegue) {}
}

// ===============
// MARK: - Methods
// ===============
private extension ProgressViewController {
    func showNextPage() {
        performSegue(withIdentifier: Segue.showTellUs)
    }
}

// ==========================
// MARK: - Facade Interaction
// ==========================
private extension ProgressViewController {
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
                                             viewIndex: 2,
                                             id: Constant.carKey)
        return ListYourCarFacade.shared.addOwnCar(parameters)
            .asVoid()
    }
}

// ==========================
// MARK: - View State Manager
// ==========================
private extension ProgressViewController {
    func showLoading() -> Guarantee<Void> {
        continueButton.isEnabled = false
        continueButton.showLoading()
        return Guarantee.value(())
    }
    
    func hideLoading() {
        continueButton.isEnabled = true
        continueButton.hideLoading()
    }
}
