//
//  AccountViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 9/18/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

final class AccountViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showContactInfo
        case showProfilePhoto
        case showTransactionHistory
        case showContactUs
    }
    
    private enum CellItems: String, CaseIterable {
        case contactInfo = "Contact info"
        case profilePhoto = "Profile photo"
        case paymentInfo = "Payment info"
        case transactionHistory = "Transaction history"
        case faq = "FAQ"
        case contactSupport = "Contact support"
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register table View cell
            registerTableViewCell()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var response: AWSCognitoIdentityUserGetDetailsResponse?
    private var user: AWSCognitoIdentityUser?
    private var pool: AWSCognitoIdentityUserPool?
    
    // MARK: Override
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension AccountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        //
        if self.user == nil {
            self.user = self.pool?.currentUser()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
        //
        UIApplication.shared.statusBarView?.backgroundColor = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .whiteNavigationBar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // show navigation bar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// ===============
// MARK: - Actions
// ===============
private extension AccountViewController {
    @IBAction func signOutTouchUpInside(_ sender: UIButton) {
        //
        let alertView = fireAlert(title: nil, message: "Are you sure?")
        //
        let logoutAction = UIAlertAction(title: "Logout", style: .default, handler: logout)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //
        alertView.addActions([logoutAction, cancelAction])
        //
        present(alertView, animated: true, completion: nil)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension AccountViewController {
    func registerTableViewCell() {
        tableView.register(AccountTableViewCell.self)
    }
    
    func logout(_ alertAction: UIAlertAction) {
        //
        tabBarController?.selectedIndex = 0
        //
        user?.signOut()
        //
        refresh()
    }
    
    func refresh() {
        user?.getDetails().continueOnSuccessWith { task in
            DispatchQueue.main.async {
                self.response = task.result
            }
            return nil
        }
    }
}

// ===================
// MARK: - Scroll View
// ===================

// MARK: Delegate
extension AccountViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            tableView.backgroundColor = .black
        } else {
            tableView.backgroundColor = .white
        }
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(CellItems.allCases[indexPath.row].rawValue)
        return cell
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = CellItems.allCases[indexPath.row]
        //
        switch row {
        case .contactInfo:
            performSegue(withIdentifier: Segue.showContactInfo)
        case .profilePhoto:
            performSegue(withIdentifier: Segue.showProfilePhoto)
        case .transactionHistory:
            performSegue(withIdentifier: Segue.showTransactionHistory)
        case .contactSupport:
            performSegue(withIdentifier: Segue.showContactUs)
        default:
            break
        }
    }
}
