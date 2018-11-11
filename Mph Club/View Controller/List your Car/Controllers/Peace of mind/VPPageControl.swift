//
//  VPPageControl.swift
//  PageControl
//  Version 1.1.0
//
//  Created by Varun on 08/06/16.
//  Copyright © 2016 VPM. All rights reserved.
//
//
//The MIT License (MIT)
//
//Copyright (c) 2016 Varun P M
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit

protocol PageControlDelegate : class {
    /// Called whenever the pageControl view is tapped.
    func pageControl(_ pageControl : VPPageControl, didSelectPageIndex pageIndex : Int)
}

enum PageControlType : Int {
    case squareBorderFilledSelected
}

class VPPageControl: UIView {
    
    var pageControlType = PageControlType.squareBorderFilledSelected
    var pageControlSpacing : CGFloat = 7
    var pageControlWidth : CGFloat = 37
    

    @IBInspectable var numberOfPages : Int = 0 {
        didSet {
            setPageControlUI()
        }
    }
    
    /// The current selected page. Defaults to 0.
    @IBInspectable var currentPage : Int = 0
    
    /// The unselected page control tintColor. Defaults to whiteColor.
    @IBInspectable var pageIndicatorTintColor : UIColor = UIColor.white
    
    /// The selected page control tintColor. Defaults to whiteColor with 50% opacity
    @IBInspectable var currentPageIndicatorTintColor : UIColor = UIColor.init(white: 1.0, alpha: 0.5)
    
    /// The delegate for handling changes in page control states.
    weak var delegate : PageControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePageControlViews()
    }
    
    
    //MARK: Update UI
    fileprivate func updatePageControlViews() {
        let actualPageControlSpacing = getActualPageControlSpacing()
        
        // Calculate the start X point for first page control
        var startX = (bounds.size.width - CGFloat(numberOfPages) * pageControlWidth - CGFloat(numberOfPages - 1) * actualPageControlSpacing) / 2
        
        for pageControlIndex in stride(from: 0, to: numberOfPages, by: 1) {
            let pageControlView = viewWithTag(pageControlIndex + 1)
            pageControlView?.center = CGPoint(x: (startX + pageControlWidth / 2), y: bounds.midY)
            setUIForPageControlView(pageControlView, withIndex: pageControlIndex)
            
            startX += actualPageControlSpacing + pageControlWidth
        }
    }
    
    fileprivate func setUIForPageControlView(_ pageControlView : UIView?, withIndex pageControlIndex : Int) {
        switch pageControlType {
            
            
        case .squareBorderFilledSelected:
            createSquarePageControl(pageControlView)
            createBorderFilledSelectedState(pageControlView, pageControlIndex: pageControlIndex)
            

        }
    }
    
    //MARK: Init UI
    fileprivate func setPageControlUI() {
        for pageControlIndex in stride(from: 0, to: numberOfPages, by: 1) {
            addSubview(getPageControlForIndex(pageControlIndex))
        }
    }
    
    fileprivate func getPageControlForIndex(_ index : Int) -> UIView {
        let pageControlView = UIView(frame: CGRect(x: 0, y: 0, width: pageControlWidth, height: 5))
        pageControlView.tag = index + 1
        
        return pageControlView
    }
    
    //MARK: Helper methods
    fileprivate func getPageControlColorForIndex(_ index : Int) -> UIColor {
        return (currentPage == index) ? currentPageIndicatorTintColor : pageIndicatorTintColor
    }
    
    // Calculate the pagecontrol's spacing
    fileprivate func getActualPageControlSpacing() -> CGFloat {
        var actualPageControlSpacing = pageControlSpacing
        return actualPageControlSpacing
    }
    

    
    fileprivate func createSquarePageControl(_ pageControlView : UIView?) {
        pageControlView?.layer.cornerRadius = 0.0
        pageControlView?.layer.masksToBounds = true
    }
    
    
    // Create pageControl displayColor
    fileprivate func createBorderPageControl(_ pageControlView : UIView?, pageControlIndex : Int) {
        pageControlView?.layer.borderWidth = 0.0
        pageControlView?.layer.borderColor = getPageControlColorForIndex(pageControlIndex).cgColor
        pageControlView?.backgroundColor = UIColor.lightGray
    }
    
    fileprivate func createFilledPageControl(_ pageControlView : UIView?, pageControlIndex : Int) {
        pageControlView?.layer.borderWidth = 0.0
        pageControlView?.backgroundColor = getPageControlColorForIndex(pageControlIndex)
        pageControlView?.layer.borderColor = UIColor.clear.cgColor
    }
    
    // Create pageControl BorderFilledSelected state
    fileprivate func createBorderFilledSelectedState(_ pageControlView : UIView?, pageControlIndex : Int) {
        if currentPage != pageControlIndex {
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
        else {
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
    
    // Create pageControl FilledBorderSelected state
    fileprivate func createFilledBorderSelectedState(_ pageControlView : UIView?, pageControlIndex : Int) {
        if currentPage == pageControlIndex {
            createBorderPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
        else {
            createFilledPageControl(pageControlView, pageControlIndex: pageControlIndex)
        }
    }
}
