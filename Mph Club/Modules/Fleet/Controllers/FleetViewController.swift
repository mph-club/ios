//
//  FleetViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class FleetViewController: UIViewController {
    // =============
    // MARK: - Enums
    // =============
    private enum Segue: String {
        case showCarDetailView
        case unwindToHome
    }
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Table View
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            // Register Header View
            registerHeaderTableView()
            // Register Cell View
            registerTableView()
        }
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    private var carList: [Vehicle] = []
    private var num = Int()
}

// =======================
// MARK: - View Contrllers
// =======================

// MARK: Life Cycle
extension FleetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        customBackButton()
        //
        createFackData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.white
        //
        UIApplication.shared.statusBarView?.backgroundColor = .white
        //
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //
        self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
        //
        navigationController?.hidesBarsOnSwipe = false
    }
}

// MARK: Navigation
extension FleetViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = Segue(rawValue: segue.identifier ?? "") else { return }
        switch identifier {
        case .showCarDetailView:
            willShowCarDetail(viewController: segue.destination as? CarDetailViewController, sender: sender)
        case .unwindToHome:
            break
        }
    }
    
    private func willShowCarDetail(viewController: CarDetailViewController?, sender: Any?) {
        guard let viewController = viewController else {
            fatalError("Could not cast destination to \(CarDetailViewController.self)")
        }
        viewController.currentVehicle = sender as? Vehicle
    }
}

// ===============
// MARK: - Actions
// ===============
private extension FleetViewController {
    @IBAction func close() {
        performSegue(withIdentifier: Segue.unwindToHome)
    }
    
    @IBAction func unwindToFleet(segue: UIStoryboardSegue) {}
}

// ===============
// MARK: - Methods
// ===============
private extension FleetViewController {
    func createFackData() {
        carList.append(Vehicle(title: "Porsche Panamera 2017", img: "panamera", price: 240, trips: 10, miles: 11))
        carList.append(Vehicle(title: "Maserati Granturismo 2016", img: "maserati", price: 140, trips: 8, miles: 4))
        carList.append(Vehicle(title: "Mercedes-Benz G-Class 2014", img: "gwagon", price: 440, trips: 5, miles: 6))
    }
    
    func customBackButton() {
        let backImg: UIImage = UIImage(named: Constant.backArrowIcon) ?? UIImage()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(FleetViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    func registerHeaderTableView() {
        tableView.register(FleetHeaderTableViewCell.self)
    }
    
    func registerTableView() {
        tableView.register(FleetTableViewCell.self)
    }
}

// ==================
// MARK: - Table View
// ==================

// MARK: Deta Source
extension FleetViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: FleetHeaderTableViewCell = tableView.dequeueReusableHeaderFooterView()
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FleetTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(carList[indexPath.row])
        return cell
    }
}

// MARK: Delegate
extension FleetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.showCarDetailView, sender: carList[indexPath.row])
    }
}
