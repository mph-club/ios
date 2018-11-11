//
//  HowGuestWillBookContainerViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/26/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

class HowGuestWillBookContainerViewController: UIViewController {

    @IBOutlet weak var submitProfile: UIButton!
    
    @IBAction func submitProfilePhotoAction(_ sender: Any) {
        showLoading()
            .then(updateListCar)
            .done(showNextPage)
            .ensure(hideLoading)
            .catch(presentError)
    }
    
    
    func showNextPage() {
        performSegue(withIdentifier: "showTerms", sender: nil)
    }
    
    func updateListCar() -> Promise<Void> {
        
        //        let jsonCar: [String: Any] = ["id": Constant.carKey,
        //                                      "license_plate": plateTextField.text!,
        //                                      "description": carDescTextView.text!]
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
                                             viewIndex: 5,
                                             id: Constant.carKey)
        return ListYourCarFacade.shared.addOwnCar(parameters)
            .asVoid()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(RegisPhotoViewController.close))
//        button1.tintColor = UIColor.black
//        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// ==========================
// MARK: - View State Manager
// ==========================
private extension HowGuestWillBookContainerViewController {
    func showLoading() -> Guarantee<Void> {
        submitProfile.isEnabled = false
        submitProfile.showLoading()
        return Guarantee.value(())
    }
    
    func hideLoading() {
        submitProfile.isEnabled = true
        submitProfile.hideLoading()
    }
}
