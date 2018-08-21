//
//  BookingSearchCell.swift
//  Mph Club
//
//  Created by Alex Cruz on 8/21/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class BookingSearchCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
