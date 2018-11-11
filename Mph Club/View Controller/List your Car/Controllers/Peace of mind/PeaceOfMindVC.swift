//
//  PeaceOfMindVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/22/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class PeaceOfMindVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var customPageControl: VPPageControl!
    

    var loginSlideViewController = LoginSlideViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavBar()
        self.enableVPPageControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // MARK: We must refactor this
        let storyboard = UIStoryboard(name: "ListCar", bundle: nil)
        switch Constant.viewIndex {
        case 1:
            let VC = storyboard.instantiateViewController(withIdentifier: "ProgressViewController")
            navigationController?.pushViewController(VC, animated: true)
        case 2:
            let VC = storyboard.instantiateViewController(withIdentifier: "TellUsAboutYourCarViewController")
            navigationController?.pushViewController(VC, animated: true)
        case 3:
            let VC = storyboard.instantiateViewController(withIdentifier: "AddAPhotoOfCarViewController")
            navigationController?.pushViewController(VC, animated: true)
        case 4:
            let VC = storyboard.instantiateViewController(withIdentifier: "AddProfilePhotoViewController")
            navigationController?.pushViewController(VC, animated: true)
        case 5:
            let VC = storyboard.instantiateViewController(withIdentifier: "ReviewTermsViewController")
            navigationController?.pushViewController(VC, animated: true)
        default:
            break
        }
    }
    
    
    func enableVPPageControl() {
        customPageControl.numberOfPages = 4
        customPageControl.currentPage = 0
        customPageControl.pageIndicatorTintColor = UIColor.black
        customPageControl.currentPageIndicatorTintColor = UIColor.green
        customPageControl.pageControlType = PageControlType.squareBorderFilledSelected
    }
    
    func selectPageControl(controlIndex: Int)  {
        customPageControl.numberOfPages = 4
        customPageControl.currentPage = controlIndex
        customPageControl.pageIndicatorTintColor = UIColor.black
        customPageControl.currentPageIndicatorTintColor = UIColor.green
        customPageControl.pageControlType = PageControlType.squareBorderFilledSelected
    }
    
    
    func hideNavBar() {
        let button1 = UIBarButtonItem(image: UIImage(named: Constant.closeIcon), style: .plain, target: self, action: #selector(PeaceOfMindVC.close))
        button1.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    @objc func close() {
            self.dismiss(animated: true, completion: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let peaceOfMindSlideVC = segue.destination as? PeaceOfMindSlideVC {
            peaceOfMindSlideVC.peaceOfMindDelegate = self
        }
    }



}

extension PeaceOfMindVC: PeaceOfMindSlideVCDelegate {
    
    func peaceOfMindSlideVC(loginSlidePageViewController: PeaceOfMindSlideVC, didUpdatePageCount count: Int) {
    }
    
    func peaceOfMindSlideVC(loginSlidePageViewController: PeaceOfMindSlideVC, didUpdatePageIndex index: Int) {
        self.selectPageControl(controlIndex: index)
    }
}


//extension PeaceOfMindVC : PageControlDelegate {
//    func pageControl(_ pageControl: VPPageControl, didSelectPageIndex pageIndex: Int) {
//        switch pageIndex {
//        case 0:
//        pageControl.backgroundColor = UIColor.white
//        case 1:
//        pageControl.backgroundColor = UIColor.yellow
//        case 2:
//        pageControl.backgroundColor = UIColor.green
//        case 3:
//        pageControl.backgroundColor = UIColor.darkGray
//        default:
//        pageControl.backgroundColor = UIColor.white
//        }
//    }
//
//}
