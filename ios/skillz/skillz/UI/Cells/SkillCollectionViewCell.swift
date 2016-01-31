//
//  SkillCollectionViewCell.swift
//  skillz
//
//  Created by Florent Capon on 27/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class SkillCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lifeImageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!
    
    var skill: Skill! {
        didSet {
            self.skillLabel.text = self.skill.name
            if (self.skill.interested) {
                self.lifeImageView.hidden = !self.skill.interested
                
            }
        }
    }
    
    class func cellSize(skill: Skill) -> CGSize {
        var cellWidth: CGFloat = (skill.name as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, 0.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.SemiBold, size: 15.0)], context: nil).width
        if (skill.interested) {
            cellWidth += (5.0 + 12.0)
        }
        return CGSizeMake(cellWidth, self.cellDefaultHeight())
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 23.0
    }
}
