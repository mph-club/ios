//
//  ListedVehiclesTVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/17/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit
import PromiseKit
import AWSCognitoIdentityProvider

final class ListedVehiclesTVC: UITableViewController {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var vehicles: [Vehicles] = []
    private var user: AWSCognitoIdentityUser?
    private var pool: AWSCognitoIdentityUserPool?
}

extension ListedVehiclesTVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vehicles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ListedVehiclesTVCell else {
            return UITableViewCell()
        }
        
        // Configure the cell...
        let car = vehicles[indexPath.row]
        cell.setContent(car)
        
        return cell
    }
    
    // - MARK: Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = vehicles[indexPath.row]
        if car.viewIndex != 0 {
            Constant.viewIndex = car.viewIndex ?? 0
            Constant.carKey = car.id
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showAddCar", sender: nil)
            }
            
        }
    }
}

// ===============
// MARK: - Methods
// ===============
private extension ListedVehiclesTVC {
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
                    let getSessionResult = getSessionTask.result
                    print(getSessionResult)
                    let idToken = getSessionResult?.idToken
                    print(idToken)
                    let accessToken = getSessionResult?.accessToken?.tokenString
                    Constant.accessToken = accessToken ?? ""
                    print("Access Token: \(accessToken ?? "")")
                    // MARK: RTANetwork Initialization
                    Network.set(adapter: TokenAdapter.shared)
                    //
                    seal.fulfill(())
                    //
                } else {
                    // FIXME: We must real error generate and handle is
                    seal.reject(NSError())
                }
                return nil
            }
        }
    }
}

// ==========================
// MARK: - Facade Interaction
// ==========================
private extension ListedVehiclesTVC {
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
private extension ListedVehiclesTVC {
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
