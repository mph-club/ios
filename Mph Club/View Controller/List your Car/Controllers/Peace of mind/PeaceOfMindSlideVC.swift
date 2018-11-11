//
//  PeaceOfMindSlideVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/23/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PeaceOfMindSlideVC: UIPageViewController {
    weak var peaceOfMindDelegate: PeaceOfMindSlideVCDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newSlideViewController(slideNumber: "slide1"),
                self.newSlideViewController(slideNumber: "slide2"),
                self.newSlideViewController(slideNumber: "slide3"),
                self.newSlideViewController(slideNumber: "slide4")]
    }()
    
    private func newSlideViewController(slideNumber: String) -> UIViewController {
        return UIStoryboard(name: "PeaceOfMind", bundle: nil) .
            instantiateViewController(withIdentifier: "\(slideNumber)ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        peaceOfMindDelegate?.peaceOfMindSlideVC(loginSlidePageViewController: self, didUpdatePageCount: orderedViewControllers.count)
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
    
    
// MARK: UIPageViewControllerDataSource

extension PeaceOfMindSlideVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        //    let previousIndex = 4
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
    
}
    
    
extension PeaceOfMindSlideVC: UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            peaceOfMindDelegate?.peaceOfMindSlideVC(loginSlidePageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}
    
    
protocol PeaceOfMindSlideVCDelegate: class {
        
        /**
         Called when the number of pages is updated.
         
         - parameter LoginSlidePageViewController: the LoginSlidePageViewController instance
         - parameter count: the total number of pages.
         */
        func peaceOfMindSlideVC(loginSlidePageViewController: PeaceOfMindSlideVC, didUpdatePageCount count: Int)
        
        /**
         Called when the current index is updated.
         
         - parameter LoginSlidePageViewController: the LoginSlidePageViewController instance
         - parameter index: the index of the currently visible page.
         */
        func peaceOfMindSlideVC(loginSlidePageViewController: PeaceOfMindSlideVC, didUpdatePageIndex index: Int)
        
}
