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
    
    var color: UIColor! {
        didSet {
            Colors.colorizeImageView(self.likeImageView, color: color)
        }
    }
    var skill: Skill! {
        didSet {
            self.skillLabel.text = self.skill.name
            self.likeImageView.hidden = !self.skill.interested
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
//    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let size = self.contentView.systemLayoutSizeFittingSize(layoutAttributes.size)
//    }
}