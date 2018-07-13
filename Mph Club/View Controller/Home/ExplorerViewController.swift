//
//  ViewController.swift
//  StretchyHeaderView
//
//  Created by sunlubo on 16/8/1.
//  Copyright © 2016年 sunlubo. All rights reserved.
//

import UIKit

class ExplorerViewController: UITableViewController {
    
    private var lastContentOffset: CGFloat = 0
    
    var num = Int()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                            withVelocity velocity: CGPoint,
                                            targetContentOffset: UnsafeMutablePointer<CGPoint>){
        
        //   print("velocity: \(velocity)")
        
        //     print("button velocity: \(scrollView.panGestureRecognizer.velocity(in: searchButton))")
        
    }
    
    
    var previousScrollMoment: Date = Date()
    var previousScrollX: CGFloat = 0
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let d = Date()
        let x = scrollView.contentOffset.y
        let elapsed = Date().timeIntervalSince(previousScrollMoment)
        let distance = (x - previousScrollX)
        let velocity = (elapsed == 0) ? 0 : fabs(distance / CGFloat(elapsed))
        previousScrollMoment = d
        previousScrollX = x
        print("vel \(velocity)")
        
        
        
        
        
        
        // print("button velocity: \(scrollView.panGestureRecognizer.velocity(in: searchButton))")
        
        // don't allow drag down on launch
        if self.lastContentOffset > -187.0 {
            
            if (self.lastContentOffset > scrollView.contentOffset.y) {
                
                // print("Moving up: \(num)")
                
                //    print("testing: \(self.lastContentOffset)")
                
                
                if self.lastContentOffset < 0.0 {
                    
                    if self.searchButton.frame.maxY <= 266 {
                        
                        if velocity > 500.0 {
                            num -= -40
                        } else if velocity > 400.0 {
                            num -= -30
                        } else if velocity > 300.0 {
                            num -= -5
                        } else if velocity > 200.0 {
                            num -= -5
                        } else if velocity > 100.0 {
                            num -= -3
                        } else {
                            num -= -3
                        }
                        
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                            self.searchButton.transform = CGAffineTransform(translationX: 0, y: CGFloat(self.num))
                        }) { _ in
                           // self.viewToAnimate.removeFromSuperview()
                        }
                        
                      
                        
                    }
                    
                }
                
            }
            else if (self.lastContentOffset < scrollView.contentOffset.y) {
                print("Moving down: \(self.searchButton.frame.maxY)")
                
                if self.searchButton.frame.maxY > 149.5 {
                    if velocity > 400.0 {
                        num += -10
                    } else if velocity > 200.0 {
                        num += -3
                    } else {
                        num += -3
                    }
                    //   print("Moving down: \(scrollView.panGestureRecognizer.velocity(in: tableView))")
                    
                    self.searchButton.transform = CGAffineTransform(translationX: 0, y: CGFloat(self.num))
                    
                    
                }
                
            }
            
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
        
        //    print(self.searchButton.frame.maxY)
        //      print(self.lastContentOffset)
    }
    
    
    
    
    var searchButton = UIButton()
    //  var buttonBackground = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.title = "mph club"
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 7))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "mph-club-logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.barColor = UIColor.black
        
        tableView.addScalableCover(with: UIImage(named: "searchBg")!)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        
        createButton()
    }
    
    
    func createButton() {
        
        
        
        searchButton = UIButton(frame: CGRect(x: 0, y: 250, width: self.view.frame.width, height: 60))
        searchButton.backgroundColor = .white
        searchButton.setTitle("Enter a city, airport, or address in FL", for: .normal)
        searchButton.setTitleColor(UIColor.lightGray, for: .normal)
        //  searchButton.layer.cornerRadius = 3
        
        let lineView = UIView(frame: CGRect(x: 0, y: searchButton.frame.size.height, width: searchButton.frame.size.width, height: 1.0))
        lineView.backgroundColor = UIColor.gray
        searchButton.addSubview(lineView)
        
        
        searchButton.addTarget(self, action: #selector(ExplorerViewController.buttonClicked), for: .touchUpInside)
        self.navigationController?.view.addSubview(searchButton)
    }
    
    @objc func buttonClicked() {
        print("Button Clicked")
        performSegue(withIdentifier: "goToMap", sender: nil)
    }
    
//    @objc func add() {
//        let detailVC = DetailViewController()
//        navigationController!.pushViewController(detailVC, animated: true)
//    }
    
    @objc func done() {
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let navigationBar = navigationController!.navigationBar
        navigationBar.attachToScrollView(tableView)
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.searchButton.isHidden = false
        
        
        
        
//        let navigationBar = navigationController!.navigationBar
//        navigationBar.barColor = UIColor.clear
        
        // self.searchButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchButton.isHidden = true
        let navigationBar = navigationController!.navigationBar
        navigationBar.reset()
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
    
    //    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    //        return 50
    //    }
    //
    //    override func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
    //        return UITableViewCell()
    //    }
    //
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    
    
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    var bool = true
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.listYourCarTitle.isHidden = true
        cell.listYourCarDesc.isHidden = true
        cell.listYourCarButton.isHidden = true
        
        if indexPath.row == 0 {
            //  JUST SPACE
        } else if indexPath.row == 1 {
            cell.collectionView.isHidden = false
            cell.headerLabel.text = "Top Rentals"
        } else if indexPath.row == 2 {
            cell.collectionView.isHidden = false
            cell.headerLabel.text = "Luxury SUVs"
        } else if indexPath.row == 3 {
            cell.collectionView.isHidden = false
            cell.headerLabel.text = "Luxury Sedans"
        } else if indexPath.row == 4 {
            cell.collectionView.isHidden = false
            cell.headerLabel.text = "Exotics"
        } else if indexPath.row == 5 {
            cell.headerLabel.text = "List your Car"
            cell.collectionView.isHidden = true
            cell.listYourCarTitle.isHidden = false
            cell.listYourCarDesc.isHidden = false
            cell.listYourCarButton.isHidden = false
            
            cell.listYourCarButton.layer.borderColor = UIColor.black.cgColor
            cell.listYourCarButton.layer.borderWidth = 3
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 400
        }
    }
    
}



extension ExplorerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 0.3
        
        //  cell.backgroundColor = model[collectionView.tag][indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

