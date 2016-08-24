//
//  SkillCollectionViewCell.swift
//  XSkillz
//
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class SkillCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillLabelTrailingConstraint: NSLayoutConstraint!
    
    var color: UIColor! {
        didSet {
            Colors.colorizeImageView(self.likeImageView, color: color)
        }
    }
    var skill: Skill! {
        didSet {
            self.skillLabel.text = self.skill.name
            self.likeImageView.hidden = !self.skill.interested
            self.skillLabelTrailingConstraint.constant = (self.skill.interested ? 23.0 : 5.0)
        }
    }
    
    class func cellSize(skill: Skill) -> CGSize {
        let labelWidth: CGFloat = (skill.name as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, 0.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: 13.0)], context: nil).width
        
        return CGSizeMake((labelWidth + (skill.interested ? 23.0 : 5.0)), self.cellDefaultHeight())
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
}