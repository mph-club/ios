//
//  ListingVehiclesViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit
import AWSCognitoIdentityProvider

final class ListingVehiclesViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case presentAddCar
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
    
    // MARK: Private
    private var vehicles: [Vehicles] = []
    private var user: AWSCognitoIdentityUser?
    private var pool: AWSCognitoIdentityUserPool?
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension ListingVehiclesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get data from backend
        showLoading()
            .then(hideNoContent)
            .then(getToken)
            .then(updateUser)
            .then(getMyCars)
            .done(tableView.reloadData)
            .done(showNoContentIfNeeded)
            .ensure(hideLoading)
            .catch(presentError)
    }
}

// ===============
// MARK: - Actions
// ===============
private extension ListingVehiclesViewController {}

// ===============
// MARK: - Methods
// ===============
private extension ListingVehiclesViewController {
    func registerTableViewCell() {
        tableView.register(ListedVehiclesTableViewCell.self)
    }
    
    func setVehicles(_ parentVechicles: ParentVechicles) {
        vehicles = parentVechicles.data.vehicles ?? []
    }
    
    func getToken() -> Promise<Void> {
        pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if self.user == nil {
            self.user = self.pool?.currentUser()
        }
        
        return Promise { seal in
            user?.getSession().continueOnSuccessWith { getSessionTask -> AnyObject? in
                if getSessionTask.isCompleted {
                    guard let accessToken = getSessionTask.result?.accessToken?.tokenString else {
                        seal.reject(getSessionTask.error ?? NSError())
                        return nil
                    }
                    Constant.accessToken = accessToken
                    print("Access Token: \(accessToken)")
                    // RTANetwork Initialization
                    Network.set(adapter: TokenAdapter.shared)
                    // Solve Promise
                    seal.fulfill(())
                } else {
                    seal.reject(getSessionTask.error ?? NSError())
                }
                return nil
            }
        }
    }
}

// ==========================
// MARK: - Facade Interaction
// ==========================
private extension ListingVehiclesViewController {
    func getMyCars() -> Promise<Void> {
        return HostDashboardFacade.shared.getMyCars()
            .get(setVehicles)
            .asVoid()
    }
    
    func updateUser() -> Promise<Void> {
        return HostDashboardFacade.shared.updateUser()
    }
}

// ==========================
// MARK: - View State Manager
// ==========================
private extension ListingVehiclesViewController {
    func showLoading() -> Guarantee<Void> {
        tableView.showLoading()
        return Guarantee.value(())
    }
    
    func hideLoading() {
        tableView.hideLoading()
    }
    
    // MARK: No Content View
    func showNoContentIfNeeded() {
        if vehicles.isEmpty {
            ViewLoadingManager.presentNoContentView(in: tableView, with: "No Result")
        }
    }
    
    func hideNoContent() -> Guarantee<Void> {
        ViewLoadingManager.hideNoContentView(from: tableView)
        return Guarantee.value(())
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Data Source
extension ListingVehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListedVehiclesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(vehicles[indexPath.row])
        
        return cell
    }
}

// MARK: Delegate
extension ListingVehiclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = vehicles[indexPath.row]
        if car.viewIndex != 0 {
            Constant.viewIndex = car.viewIndex ?? 0
            Constant.carKey = car.id
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Segue.presentAddCar)
            }
        }
    }
}

// ===========================
// MARK: - StoryboardInitiable
// ===========================
extension ListingVehiclesViewController: StoryboardInitiable {}
