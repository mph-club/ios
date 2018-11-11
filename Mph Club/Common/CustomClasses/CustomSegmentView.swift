//
//  CustomSegmentView.swift
//  Mph Club
//
//  Created by behzad ardeh on 11/1/18.
//  Copyright © 2018 Mph Club. All rights reserved.
//

import UIKit

protocol CustomSegmentViewDelegate: class {
    func customSegmentView(_ customSegmentView: CustomSegmentView, didSelectItem index: Int)
}

@IBDesignable
final class CustomSegmentView: UIControl {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Public
    var items: [String] = [] {
        didSet {
            setupView()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    // MARK: Private
    private var labels: [UILabel] = []
    private var selectedLineView: UIView = UIView()
    
    // MARK: IBInspectable
    @IBInspectable var textColor: UIColor = .darkGray {
        didSet {
            setColors()
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = UIColor.PaletteName.green.color {
        didSet {
            setColors()
        }
    }
    
    // MARK: Delegate
    weak var delegate: CustomSegmentViewDelegate?
    
    // ===============
    // MARK: - Initial
    // ===============
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //
        setupView()
    }
}

// =================
// MARK: - UIControl
// =================

// MARK: Life Cycle
extension CustomSegmentView {
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        let selectFrame = CGRect(x: bounds.minX,
                                 y: bounds.maxY,
                                 width: bounds.width / CGFloat(items.count),
                                 height: 2)
        //
        selectedLineView.frame = selectFrame
        selectedLineView.backgroundColor = selectedTextColor
        //
        displayNewSelectedIndex()
    }
}

// =====================
// MARK: - Override Func
// =====================
extension CustomSegmentView {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex: Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if let calculatedIndex = calculatedIndex {
            selectedIndex = calculatedIndex
            sendActions(for: .valueChanged)
        }
        return false
    }
}

// ===============
// MARK: - Methods
// ===============
private extension CustomSegmentView {
    func setColors() {
        labels.forEach { $0.textColor = textColor }
        //
        if !labels.isEmpty {
            labels[selectedIndex].textColor = selectedTextColor
        }
        //
        selectedLineView.backgroundColor = selectedTextColor
    }
    
    func setupLabels() {
        items.forEach { title in
            let label = UILabel()
            
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20)
            label.adjustsFontSizeToFitWidth = true
            
            let attributesSelected: [NSAttributedString.Key: Any] = [.foregroundColor: textColor]
            label.attributedText = NSAttributedString(string: title, attributes: attributesSelected)
            
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    func setupView() {
        setupLabels()
        //
        addIndividualItemConstraints(items: labels, mainView: self, padding: 8)
        //
        insertSubview(selectedLineView, at: 0)
    }
    
    func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {
        for (index, button) in items.enumerated() {
            let topConstraint = NSLayoutConstraint(item: button,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: mainView,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: button,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: mainView,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 0)
            
            var rightConstraint: NSLayoutConstraint!
            if index == items.count - 1 {
                rightConstraint = NSLayoutConstraint(item: button,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: -padding)
            } else {
                let nextButton = items[index + 1]
                rightConstraint = NSLayoutConstraint(item: button,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: nextButton,
                                                     attribute: .left,
                                                     multiplier: 1.0,
                                                     constant: -padding)
            }
            
            var leftConstraint: NSLayoutConstraint!
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: mainView,
                                                    attribute: .left,
                                                    multiplier: 1.0,
                                                    constant: padding)
            } else {
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: prevButton,
                                                    attribute: .right,
                                                    multiplier: 1.0,
                                                    constant: padding)
                
                let firstItem = items[0]
                let widthConstraint = NSLayoutConstraint(item: button,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: firstItem,
                                                         attribute: .width,
                                                         multiplier: 1.0 ,
                                                         constant: 0)
                
                mainView.addConstraint(widthConstraint)
                
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
            self.layoutIfNeeded()
        }
    }
    
    func displayNewSelectedIndex() {
        labels.forEach { $0.textColor = textColor }
        //
        let label = labels[selectedIndex]
        label.textColor = selectedTextColor
        //
        delegate?.customSegmentView(self, didSelectItem: selectedIndex)
        //
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [.curveEaseOut], animations: {
            
            let thumbFrame = CGRect(x: label.frame.minX,
                                    y: label.frame.maxY - 2,
                                    width: label.frame.width,
                                    height: 2)
            
            self.selectedLineView.frame = thumbFrame
            
        }, completion: nil)
    }
}
