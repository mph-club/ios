//
//  AboutYourCarContainerViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/19/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

extension AboutYourCarContainerViewController: ChangeButtonColorDelegate {
    func setColor(color: UIColor) {
        print(color)
        nextButton.backgroundColor = color
    }
}

class AboutYourCarContainerViewController: UIViewController {
    
    @IBOutlet weak var nextButton: NextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(CarEligibilityViewController.close))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func close() {
        self.performSegue(withIdentifier: "unwindToCheckList", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tellUsAboutYourCarViewController = segue.destination as? TellUsAboutYourCarViewController {
            tellUsAboutYourCarViewController.delegate = self
        }
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.clear.cgColor
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        self.navigationController?.navigationBar.layer.backgroundColor = UIColor.clear.cgColor
//    }
 

}
