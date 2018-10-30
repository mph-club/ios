//
//  ProfileViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 9/18/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

final class ProfileViewController: UIViewController {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var response: AWSCognitoIdentityUserGetDetailsResponse?
    private var user: AWSCognitoIdentityUser?
    private var pool: AWSCognitoIdentityUserPool?
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        //
        if self.user == nil {
            self.user = self.pool?.currentUser()
        }
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ProfileViewController {
    @IBAction func signOut(_ sender: UIButton) {
        //
        tabBarController?.selectedIndex = 0
        //
        user?.signOut()
        //
        refresh()
    }
}

// ===============
// MARK: - Methods
// ===============
private extension ProfileViewController {
    func refresh() {
        user?.getDetails().continueOnSuccessWith { task in
            DispatchQueue.main.async {
                self.response = task.result
            }
            return nil
        }
    }
}
