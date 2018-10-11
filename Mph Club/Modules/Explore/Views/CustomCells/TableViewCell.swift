

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet public weak var collectionView: UICollectionView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var listYourCarTitle: UITextView!
    @IBOutlet weak var listYourCarDesc: UITextView!
    @IBOutlet weak var listYourCarButton: UIButton!
    
}

extension TableViewCell {

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.layer.borderColor = UIColor.clear.cgColor
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
