//
//  DetailViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

final class FeatureAttributesCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
}

final class SimilarCarCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pricePerDay: UILabel!
    @IBOutlet weak var trips: UILabel!
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2 {
            return featureItems.count
        } else if collectionView.tag == 1 {
            return carAttributes.count
        } else {
            return similarCarList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FeatureAttributesCell else { return UICollectionViewCell() }
            cell.img.image = UIImage(named: featureItems[indexPath.row])
            return cell
        } else if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CarAttributesCell else { return UICollectionViewCell() }
            cell.img.image = UIImage(named: carAttributes[indexPath.row].img ?? "")
            cell.titleLabel.text = carAttributes[indexPath.row].title
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SimilarCarCell else { return UICollectionViewCell() }
            cell.title.text = similarCarList[indexPath.row].title
//            cell.img.image = similarCarList[indexPath.row].img
            cell.pricePerDay.text = "\(String(describing: similarCarList[indexPath.row].price ?? 0))"
            cell.trips.text = "\(String(describing: similarCarList[indexPath.row].trips ?? 0)) Trips"
            
            return cell
        }

    }

}

struct CarAttribute {
    let title: String?
    let img: String?
}

struct SimilarCar {
    let title: String?
    let img: UIImage?
    let price: Float?
    let trips: Int?
}

extension DetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
 
        if (URL.absoluteString == kURLString) {
            print("testing123")
            performSegue(withIdentifier: "reviews", sender: nil)
        }
        return false
    }
}

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var featureItems = ["automaticTransmission32Px", "bluetooth32Px", "sun32Px", "music32Px"]
    
    var carAttributes = [CarAttribute]()
    var similarCarList = [SimilarCar]()
    var newBackButton = UIBarButtonItem()
    
    private let kURLString = "https://www.test.com"
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var lastContentOffset: CGFloat = 0
    
    var vehicle: Vehicle?
    
    @IBOutlet weak var vehicleImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        scrollView.isDirectionalLockEnabled = false
        
        
        guard let vehicle = vehicle else { return }
        print(vehicle)
        
        self.vehicleImg.image = UIImage(named: vehicle.img)
        self.titleLabel.text = vehicle.title
        self.tripLabel.text = "\(String(describing: vehicle.trips)) trips"
        self.milesLabel.text = "\(String(describing: vehicle.miles)) mi"
        
        setDummyData()
        reviews()
        
        scrollView.delegate = self
        
        let backImg: UIImage = UIImage(named: Constant.backArrowIcon) ?? UIImage()
        newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        self.continueButton.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBarStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    

    func setNavigationBarStyle() {
        let color = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.shadowImage = UIColor.gray.as1ptImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = color
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    func reviews() {
        self.textView.delegate = self
        
        let originalText = "Another great mph experience with an amazing vehicle and host that made pickup and return super easy…read more"
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        
        let linkRange = attributedOriginalText.mutableString.range(of: "read more")
        attributedOriginalText.addAttribute(.link, value: kURLString, range: linkRange)
        
        
        self.textView.isSelectable = true
        self.textView.isEditable = false
        self.textView.textColor = UIColor.black
        
        let linkAttributes: [String : Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0),
            NSAttributedString.Key.underlineColor.rawValue: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.single.rawValue
        ]
        
        // textView is a UITextView
        textView.linkTextAttributes = convertToOptionalNSAttributedStringKeyDictionary(linkAttributes)
        textView.attributedText = attributedOriginalText
    }
    
    func setDummyData() {
        carAttributes.append(CarAttribute(title: "2 Seats", img: "seat64Px"))
        carAttributes.append(CarAttribute(title: "2 Door", img: "door64Px"))
        carAttributes.append(CarAttribute(title: "13 MPG", img: "gas64Px"))
        carAttributes.append(CarAttribute(title: "GPS", img: "satellite64Px"))
        
        similarCarList.append(SimilarCar(title: "Ferrari California 2013", img: UIImage(named: "dontknowcar"), price: 200, trips: 4))
        similarCarList.append(SimilarCar(title: "Ferrari California 2014", img: UIImage(named: "dontknowcar"), price: 200, trips: 4))
        similarCarList.append(SimilarCar(title: "Ferrari California 2015", img: UIImage(named: "dontknowcar"), price: 200, trips: 4))
    }


    
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if self.navigationController != nil {
//
//
//
//            var offset = scrollView.contentOffset.y / 150
//            if offset > 1 {
//
//                self.vehicleImg.frame.size.width -= offset
//                self.vehicleImg.frame.size.height -= offset
//
//
//                offset = 1
//                let color = UIColor.white
//                self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//                self.navigationController?.navigationBar.shadowImage = UIImage()
//                self.navigationController?.navigationBar.shadowImage = UIColor.gray.as1ptImage()
//                self.navigationController?.navigationBar.isTranslucent = true
//                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
//
//                let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
//                newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
//                self.navigationItem.leftBarButtonItem = newBackButton
//                self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
//
//
//            } else {
//                self.vehicleImg.frame.size.width += offset
//                self.vehicleImg.frame.size.height += offset
//
//
//                self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
//                let color = UIColor.clear
//                self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
//                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
//
//                let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
//                newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
//                self.navigationItem.leftBarButtonItem = newBackButton
//                self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
//
//            }
//        }
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToFleet", sender: nil)
    }
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {}
    
    

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
