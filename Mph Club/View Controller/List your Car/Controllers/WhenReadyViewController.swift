//
//  WhenReadyViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/23/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit

class WhenReadyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateListCar()
            .done(doneFlow)
            .catch(presentError)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                             viewIndex: 0,
                                             id: Constant.carKey)
        return ListYourCarFacade.shared.addOwnCar(parameters)
            .asVoid()
    }
    
    func doneFlow() {
        self.dismiss(animated: true, completion: nil)
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
