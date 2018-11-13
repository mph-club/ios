//
//  PeaceOfMindVC.swift
//  Mph Club
//
//  Created by Alex Cruz on 10/22/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class PeaceOfMindVC: UIViewController {
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: View
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: Page Controll
    @IBOutlet private weak var customPageControl: VPPageControl!
    
    // ==================
    // MARK: - Properties
    // ==================
}

// =======================
// MARK: - View Controller
// =======================

// MARK: Life Cycle
extension PeaceOfMindVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        (navigationController?.navigationBar as? CustomNavigationBar)?.styleView = .transparentWithWhiteTint
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // FIXME: We must refactor this
        switch Constant.viewIndex {
        case 1:
            let progressVC = UIStoryboard.listCar.instantiateViewController(withIdentifier: "ProgressViewController")
            navigationController?.pushViewController(progressVC, animated: true)
        case 2:
            let tellUsVC = UIStoryboard.listCar.instantiateViewController(withIdentifier: "TellUsAboutYourCarViewController")
            navigationController?.pushViewController(tellUsVC, animated: true)
        case 3:
            let addPhotoOfCarVC = UIStoryboard.listCar.instantiateViewController(withIdentifier: "AddAPhotoOfCarViewController")
            navigationController?.pushViewController(addPhotoOfCarVC, animated: true)
        case 4:
            let addProfilePhotoVC = UIStoryboard.listCar.instantiateViewController(withIdentifier: "AddProfilePhotoViewController")
            navigationController?.pushViewController(addProfilePhotoVC, animated: true)
        case 5:
            let termsVC = UIStoryboard.listCar.instantiateViewController(withIdentifier: "ReviewTermsViewController")
            navigationController?.pushViewController(termsVC, animated: true)
        default:
            break
        }
    }
}

// MARK: Navigation
extension PeaceOfMindVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let peaceOfMindSlideVC = segue.destination as? PeaceOfMindSlideVC {
            peaceOfMindSlideVC.peaceOfMindDelegate = self
        }
    }
}

// ===============
// MARK: - Actions
// ===============
private extension PeaceOfMindVC {
    @IBAction func closeView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// ===============
// MARK: - Methods
// ===============
private extension PeaceOfMindVC {
    func selectPageControl(controlIndex: Int) {
        customPageControl.numberOfPages = 4
        customPageControl.currentPage = controlIndex
    }
}

// ====================================================
// MARK: - Peace Of Mind Slide View Controller Delegate
// ====================================================
extension PeaceOfMindVC: PeaceOfMindSlideVCDelegate {
    func peaceOfMindSlideVC(loginSlidePageViewController: PeaceOfMindSlideVC, didUpdatePageCount count: Int) {}
    
    func peaceOfMindSlideVC(loginSlidePageViewController: PeaceOfMindSlideVC, didUpdatePageIndex index: Int) {
        selectPageControl(controlIndex: index)
    }
}
