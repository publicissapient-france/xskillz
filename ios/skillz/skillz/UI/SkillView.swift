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
    @IBOutlet weak var lifeImageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillLabelTrailingConstraint: NSLayoutConstraint!

    var skill: Skill! {
        didSet {
            self.skillLabel.text = self.skill.name
            self.lifeImageView.hidden = !self.skill.interested
            self.skillLabelTrailingConstraint.constant = self.skill.interested ? 17.0 : 0.0
        }
    }
    
    class func loadFromNib() -> SkillView {
        return UINib(nibName: "SkillView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! SkillView
    }
    
    override func sizeToFit() {
        let cellSize: CGSize = SkillView.cellSize(self.skill)
        var frameRect: CGRect = self.frame
        frameRect.size.width = cellSize.width
        self.frame = frameRect
    }
    
    class func cellSize(skill: Skill) -> CGSize {
        var cellWidth: CGFloat = (skill.name as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, 0.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.SemiBold, size: 15.0)], context: nil).width
        if (skill.interested) {
            cellWidth += (5.0 + 12.0)
        }
        cellWidth += 1.0
        return CGSizeMake(cellWidth, self.cellDefaultHeight())
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 23.0
    }
}
