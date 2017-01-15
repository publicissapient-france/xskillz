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
            self.likeImageView.isHidden = !self.skill.interested
            self.skillLabelTrailingConstraint.constant = (self.skill.interested ? 23.0 : 5.0)
        }
    }
    
    
    // MARK: - Size
    class func cellSize(_ skill: Skill) -> CGSize {
        let labelWidth: CGFloat = (skill.name as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.regular, size: 13.0)], context: nil).width
        
        return CGSize(width: (labelWidth + (skill.interested ? 23.0 : 5.0)), height: self.cellDefaultHeight())
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
}
