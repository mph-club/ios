////
////  HomeViewController.swift
////  Mph Club
////
////  Created by Alex Cruz on 7/9/18.
////  Copyright © 2018 Mph Club. All rights reserved.
////
//
//import UIKit
//
//class HomeViewController: UIViewController, UIScrollViewDelegate {
//
//
//
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    @IBOutlet weak var tableView: UITableView!
//
//    var navigationBarOriginalOffset : CGFloat?
//
//
//    private var lastContentOffset: CGFloat = 0
//
//    @IBOutlet weak var searchButton: UIButton!
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//
//
////        print(searchButton.frame.origin)
////        print(self.view)
////        print(searchButton.convert(searchButton.frame.origin, to: self.view))
//
//
// //               searchButton.frame.origin.y = max(navigationBarOriginalOffset!, scrollView.contentOffset.y)
////                print(max(navigationBarOriginalOffset!, scrollView.contentOffset.y))
//
//
//
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            // move up
//         //   print(" move up")
//        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            // move down
//         //   print(" move down")
//
//
//
//
//            if navigationBarOriginalOffset! == scrollView.contentOffset.y {
//            //    print(1234)
//      //          searchButton.frame = CGRect(x: 10, y: navigationBarOriginalOffset!, width: self.scrollView.frame.width-20, height: 50)
//            }
//
//        }
//
//
//    }
//
////    func scrollViewDidScroll(scrollView: UIScrollView) {
////
////
////
////
//////        navigationController?.navigationBar.frame.origin.y = max(navigationBarOriginalOffset!, scrollView.contentOffset.y)
//////        print(max(navigationBarOriginalOffset!, scrollView.contentOffset.y))
////    }
//
////    if(searchButton!.center.y < 555) {
////    searchButton!.center = CGPoint(x: searchButton!.center.x, y: searchButton!.center.y + translation.y)
////    }else {
////    searchButton!.center = CGPoint(x: searchButton!.center.x, y: 554)
////    }
//
//    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
//
//        let vel = gestureRecognizer.velocity(in: self.scrollView)
//        if vel.x > 0 {
//            // user dragged towards the right
//         //   print("right")
//        }
//        else {
//            // user dragged towards the left
//         //   print("left")
//        }
//
//        if vel.y > 0 {
//            // user dragged towards the down
//            print("down")
//
////            if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
////                let translation = gestureRecognizer.translation(in: self.view)
////                //  print(gestureRecognizer.view!.center.y)
////                if(gestureRecognizer.view!.center.y < 555) {
////                    print(1)
////                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
////
////                    if searchButton!.center.y < 85 {
////                        print(searchButton!.center.y)
////                        print(2)
////                        searchButton!.center = CGPoint(x: searchButton!.center.x, y: searchButton!.center.y + translation.y)
////                    }
////
////                }else {
////                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 554)
////
////                    searchButton!.center = CGPoint(x: searchButton!.center.x, y: 554)
////                    // gestureRecognizer.velocity(in: searchButton).applying(CGAffineTransform(scaleX: 2.0, y: 2.0))
////                }
////
////                gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
////            }
//
//
//        }
//        else {
//            // user dragged towards the up
//         //   print("up")
//
//            if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
//                let translation = gestureRecognizer.translation(in: self.view)
//              //  print(gestureRecognizer.view!.center.y)
//                if(gestureRecognizer.view!.center.y < 555) {
//                    print(1)
//                //    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
//
//                    if searchButton!.center.y > 85 {
//                        print(searchButton!.center.y)
//                         print(2)
//                        searchButton!.center = CGPoint(x: searchButton!.center.x, y: searchButton!.center.y + translation.y)
//                    }
//
//                }else {
//                //    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 554)
//
//                    searchButton!.center = CGPoint(x: searchButton!.center.x, y: 554)
//                   // gestureRecognizer.velocity(in: searchButton).applying(CGAffineTransform(scaleX: 2.0, y: 2.0))
//                }
//
//                gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
//            }
//
//
//        }
//
//
//
//
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let gesture = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.wasDragged(gestureRecognizer:)))
//        scrollView.addGestureRecognizer(gesture)
//        scrollView.isUserInteractionEnabled = true
//        gesture.delegate = self as? UIGestureRecognizerDelegate
//
//
//
//
//        self.scrollView.delegate = self as? UIScrollViewDelegate
//
//        navigationBarOriginalOffset = (navigationController?.navigationBar.frame.origin.y)! + 26
//
//    //    print(navigationBarOriginalOffset!)
//
//    //    hideLeftBarButton()
//
////        tableView.estimatedSectionHeaderHeight = 40.0
////        self.automaticallyAdjustsScrollViewInsets = false
//        // Set a header for the table view
////        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
////        header.backgroundColor = .red
////        tableView.tableHeaderView = header
//
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//      //  hideLeftBarButton()
////    self.tabBarController?.navigationItem.hidesBackButton = true
//    self.navigationController?.setNavigationBarHidden(true, animated: animated)
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(false)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//     //   self.navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    func hideLeftBarButton() {
//      //  self.tabBarController?.navigationItem.leftBarButtonItem?.disab
//      //  self.tabBarController?.navigationItem.hidesBackButton = true
//      //  self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
//
////        self.tabBarController?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
////        self.tabBarController?.navigationController?.navigationBar.shadowImage = UIImage()
////        self.tabBarController?.navigationController?.navigationBar.isTranslucent = false
////        self.tabBarController?.navigationController?.view.backgroundColor = UIColor.clear
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
////        self.tabBarController?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
////        self.tabBarController?.navigationController?.navigationBar.shadowImage = UIImage()
////        self.tabBarController?.navigationController?.navigationBar.isTranslucent = false
////        self.tabBarController?.navigationController?.view.backgroundColor = UIColor.black
//    }
//
//
//    @IBAction func goToFleet(_ sender: UIButton) {
//        performSegue(withIdentifier: "goToFleet", sender: nil)
//    }
//
////    @IBAction func goToMap(_ sender: UIButton) {
////        performSegue(withIdentifier: "goToMap", sender: nil)
////    }
//
//    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
