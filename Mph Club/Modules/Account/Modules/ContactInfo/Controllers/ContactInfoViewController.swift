//
//  ContactInfoViewController.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class ContactInfoViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showChangeYourEmail
        case showYourPhone
    }
    
    private enum CellItems: Int {
        case email
        case phoneNumber
        case password
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register table view cell
            registerTableViewCell()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Mock Data
    let contactInfoItems = [ContactInfo(title: "Email", value: "mikelong.corporation@icloud.com"),
                            ContactInfo(title: "Phone number", value: "786-400-0389"),
                            ContactInfo(title: nil, value: "Password")]
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ContactInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ContactInfoViewController {}

// ===============
// MARK: - Methods
// ===============
private extension ContactInfoViewController {
    func registerTableViewCell() {
        tableView.register(ContactInfoTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension ContactInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(contactInfoItems[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension ContactInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = CellItems(rawValue: indexPath.row) else { return }
        //
        switch row {
        case .email:
            performSegue(withIdentifier: Segue.showChangeYourEmail)
        case .phoneNumber:
            performSegue(withIdentifier: Segue.showYourPhone)
        case .password:
            break
        }
    }
}
