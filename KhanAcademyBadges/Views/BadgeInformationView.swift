//
//  BadgeInformationView.swift
//  KhanAcademyBadges
//
//  Created by Jimmy Yue on 12/14/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit
import Foundation

class BadgeInformationView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var cellImage: UIImageView
    @IBOutlet weak var 
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
                xibSetup()
        
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        view.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FormCellView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
        
    }
    

}
