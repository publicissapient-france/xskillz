//
//  SkillView.swift
//  skillz
//
//  Created by Florent Capon on 11/02/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class SkillView: UIView {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillLabelTrailingConstraint: NSLayoutConstraint!

    var skill: Skill! {
        didSet {
            self.skillLabel.text = self.skill.name
            Colors.colorizeImageView(self.likeImageView, color: skill.domain?.colorObject)
            self.likeImageView.hidden = !self.skill.interested
            self.skillLabelTrailingConstraint.constant = self.skill.interested ? 18.0 : 0.0
        }
    }
    
    
    // MARK: - Init
    class func loadFromNib() -> SkillView {
        return UINib(nibName: "SkillView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! SkillView
    }
    
    
    // MARK: - Size
    func sizeFitting() -> CGSize {
        return SkillView.size(self.skill)
    }
    
    class func size(skill: Skill) -> CGSize {
        var skillNameLabelWidth: CGFloat = (skill.name as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, 0.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: 13.0)], context: nil).width
        if (skill.interested) {
            skillNameLabelWidth += (5.0 + 13.0)
        }
        return CGSizeMake((skillNameLabelWidth + 1.0), self.defaultHeight())
    }
    
    class func defaultHeight() -> CGFloat {
        return 25.0
    }
}