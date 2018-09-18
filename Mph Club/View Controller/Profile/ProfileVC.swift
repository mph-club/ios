//
//  ProfileVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 9/18/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class ProfileVC: UIViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
    }

    @IBAction func signOut(_ sender: AnyObject) {
        self.user?.signOut()
        refresh()

    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
            })
            return nil
        }
    }
    

}
