//
//  LoginSlideViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 6/27/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class LoginSlideViewController: UIPageViewController {
    
    
    
    var loginSlideDelegate: LoginSlideViewControllerDelegate?
    

    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newSlideViewController(slideNumber: "slide1"),
                self.newSlideViewController(slideNumber: "slide2"),
                self.newSlideViewController(slideNumber: "slide3")]
    }()
    
    private func newSlideViewController(slideNumber: String) -> UIViewController {
        return UIStoryboard(name: "LoginSlide", bundle: nil) .
            instantiateViewController(withIdentifier: "\(slideNumber)ViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        loginSlideDelegate?.loginSlideViewController(tutorialPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        
//        if let initialViewController = orderedViewControllers.first {
//            _scrollToViewController(viewController: initialViewController)
//        }
//
//
//
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     Scrolls to the next view controller.
     */
//    func scrollToNextViewController() {
//        if let visibleViewController = viewControllers?.first,
//            let nextViewController = pageViewController(self,
//                                                        viewControllerAfter: visibleViewController) {
//            _scrollToViewController(viewController: nextViewController)
//        }
//    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
//    func scrollToViewController(index newIndex: Int) {
//        if let firstViewController = viewControllers?.first,
//            let currentIndex = orderedViewControllers.index(of: firstViewController) {
//            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
//            let nextViewController = orderedViewControllers[newIndex]
//            _scrollToViewController(viewController: nextViewController, direction: direction)
//
//        }
//    }
//
//
//
//    /**
//     Scrolls to the given 'viewController' page.
//
//     - parameter viewController: the view controller to show.
//     */
//    private func _scrollToViewController(viewController: UIViewController,
//                                         direction: UIPageViewControllerNavigationDirection = .forward) {
//        setViewControllers([viewController],
//                           direction: direction,
//                           animated: true,
//                           completion: { (finished) -> Void in
//                            // Setting the view controller programmatically does not fire
//                            // any delegate methods, so we have to manually notify the
//                            // 'tutorialDelegate' of the new index.
//                            self.notifyTutorialDelegateOfNewIndex()
//        })
//    }
//
//    /**
//     Notifies '_tutorialDelegate' that the current page index was updated.
//     */
//    private func notifyTutorialDelegateOfNewIndex() {
//        if let firstViewController = viewControllers?.first,
//            let index = orderedViewControllers.index(of: firstViewController) {
//            loginSlideDelegate?.loginSlideViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: UIPageViewControllerDataSource

extension LoginSlideViewController: UIPageViewControllerDataSource {
    
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
    
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return orderedViewControllers.count
//    }
//
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//        let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
//                return 0
//        }
//        return firstViewControllerIndex
//    }
    
}


extension LoginSlideViewController: UIPageViewControllerDelegate {
    
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            didFinishAnimating finished: Bool,
//                            previousViewControllers: [UIViewController],
//                            transitionCompleted completed: Bool) {
//        notifyTutorialDelegateOfNewIndex()
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            loginSlideDelegate?.loginSlideViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}


protocol LoginSlideViewControllerDelegate {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func loginSlideViewController(tutorialPageViewController: LoginSlideViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func loginSlideViewController(tutorialPageViewController: LoginSlideViewController, didUpdatePageIndex index: Int)
    
}
