//
//  MphTextField.swift
//  Mph Club
//
//  Created by Alex Cruz on 7/3/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

class MphTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBottomBorder()
    }
    
    
    private func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    
    public func setBottomSingleBorder(color: CGColor) {
        self.layer.shadowColor = color
    }
    


}
