//
//  ProgressViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/6/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var checkForEligible: UIImageView!
    
    @IBOutlet private weak var lastButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(ProgressViewController.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
    }
    
    @objc func close() {
        let fireAction = fireActionSheet(title: "Before you close", message: "If you proceed with this action, you'll have to start from the beginning.")
        
        fireAction.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        fireAction.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        
        self.present(fireAction, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToCheckList(segue: UIStoryboardSegue) {}
    
    
//    @IBAction func close(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
//    }
    
    func showNextPage() {
        performSegue(withIdentifier: "showTellUs", sender: nil)
    }
    
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
    
    
    @IBAction func lastStepTouchUpInsideAction(_ sender: UIButton) {        
        showLoading()
            .then(updateListCar)
            .done(showNextPage)
            .ensure(hideLoading)
            .catch(presentError)
        
    }
    
}

// ==========================
// MARK: - View State Manager
// ==========================
private extension ProgressViewController {
    func showLoading() -> Guarantee<Void> {
        lastButton.isEnabled = false
        lastButton.showLoading()
        return Guarantee.value(())
    }
    
    func hideLoading() {
        lastButton.isEnabled = true
        lastButton.hideLoading()
    }
}
