//
//  DetailViewController.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/9/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class FeatureAttributesCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
}

class SimilarCarCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeatureAttributesCell
            cell.img.image = UIImage(named: featureItems[indexPath.row])
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarAttributesCell
            cell.img.image = UIImage(named: carAttributes[indexPath.row].img!)
            cell.titleLabel.text = carAttributes[indexPath.row].title
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimilarCarCell
            cell.title.text = similarCarList[indexPath.row].title!
            cell.img.image = UIImage(named: similarCarList[indexPath.row].img!)
            cell.pricePerDay.text = "\(String(describing: similarCarList[indexPath.row].price!))"
            cell.trips.text = "\(String(describing: similarCarList[indexPath.row].trips!)) Trips"
            
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
    let img: String?
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    var lastContentOffset: CGFloat = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDummyData()
        reviews()
        
        scrollView.delegate = self
        
        let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
        newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
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
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.blue,
            NSAttributedStringKey.underlineColor.rawValue: UIColor.lightGray,
            NSAttributedStringKey.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue
        ]
        
        // textView is a UITextView
        textView.linkTextAttributes = linkAttributes
        textView.attributedText = attributedOriginalText
    }
    
    func setDummyData() {
        carAttributes.append(CarAttribute(title: "2 Seats", img: "seat64Px"))
        carAttributes.append(CarAttribute(title: "2 Door", img: "door64Px"))
        carAttributes.append(CarAttribute(title: "13 MPG", img: "gas64Px"))
        carAttributes.append(CarAttribute(title: "GPS", img: "satellite64Px"))
        
        similarCarList.append(SimilarCar(title: "Ferrari California 2013", img: "dontknowcar", price: 200, trips: 4))
        similarCarList.append(SimilarCar(title: "Ferrari California 2014", img: "dontknowcar", price: 200, trips: 4))
        similarCarList.append(SimilarCar(title: "Ferrari California 2015", img: "dontknowcar", price: 200, trips: 4))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > 1 {
            offset = 1
            let color = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarView?.backgroundColor = color
            
            let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
            newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        } else {
            let color = UIColor.clear
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.shared.statusBarView?.backgroundColor = color
            
            let backImg: UIImage = UIImage(named: Constant.backArrowIcon)!
            newBackButton = UIBarButtonItem(image: backImg, style: .done, target: self, action: #selector(DetailViewController.back(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        }
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToFleet", sender: nil)
    }
    
    

}


extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

