//
//  BadgeInformationViewController.swift
//  KhanAcademyBadges
//
//  Created by Jimmy Yue on 12/14/15.
//  Copyright © 2015 Augmented Humanity. All rights reserved.
//

import UIKit

class BadgeInformationViewController: UIViewController {
    
    @IBOutlet weak var badgeView: UIImageView!
    @IBOutlet weak var badgeTitleLabel: UILabel!
    @IBOutlet weak var badgeDetailLabel: UILabel!
    
    var image: UIImage?
    var badgeTitleString: String?
    var badgeDetailString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        badgeView.image = image
        badgeTitleLabel.text = badgeTitleString
        badgeDetailLabel.text = badgeDetailString
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "popViewController:"))
        
    }
    
    
    
    func initWithBadges(image: UIImage, title: String, description: String) -> BadgeInformationViewController {
        self.image = image
        self.badgeTitleString = title
        self.badgeDetailString = description
        return self
        
    }
    
    func popViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
