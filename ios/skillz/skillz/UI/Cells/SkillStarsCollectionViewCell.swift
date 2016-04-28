//
//  SkillStarsCollectionViewCell.swift
//  skillz
//
//  Created by Florent Capon on 27/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class SkillStarsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var noStarView: UIView!
    @IBOutlet weak var star1View: UIView!
    @IBOutlet weak var star2View: UIView!
    @IBOutlet weak var star3View: UIView!
    @IBOutlet weak var star1ViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var star2ViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var star3ViewCenterXConstraint: NSLayoutConstraint!
    
    var level: SkillLevel! {
        didSet {
            self.noStarView.hidden = self.level != SkillLevel.NoSkill
            self.star1View.hidden = (self.level == SkillLevel.NoSkill)
            self.star2View.hidden = (self.level == SkillLevel.NoSkill || self.level == SkillLevel.Beginner)
            self.star3View.hidden = (self.level == SkillLevel.NoSkill || self.level == SkillLevel.Beginner || self.level == SkillLevel.Confirmed)
            
            switch self.level! {
            case SkillLevel.NoSkill:
                break
                
            case SkillLevel.Beginner:
                self.star1ViewCenterXConstraint.constant = 0.0
                break
                
            case SkillLevel.Confirmed:
                self.star1ViewCenterXConstraint.constant = -((self.star1View.bounds.size.width + 5.0) / 2.0)
                self.star2ViewCenterXConstraint.constant = ((self.star2View.bounds.size.width + 5.0) / 2.0)
                break
                
            case SkillLevel.Expert:
                self.star1ViewCenterXConstraint.constant = -(self.star1View.bounds.size.width + 5.0)
                self.star2ViewCenterXConstraint.constant = 0.0
                self.star3ViewCenterXConstraint.constant = (self.star3View.bounds.size.width + 5.0)
                break
            }
        }
    }
    var domain: Domain! {
        didSet {
            self.backgroundColorView.backgroundColor = self.domain.colorObject()
        }
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 35.0
    }
}
