//
//  SkillSearchListCollectionViewCell.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class SkillSearchListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfUsersLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    var skill:Skill?
    
    class func cellDefaultHeight() -> CGFloat {
        return 30.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.text = nil
        self.numberOfUsersLabel.text = nil
    }
    
    func skill(skill: Skill, searchString: String, numberOfUsers: Int) -> Void {
        let fontSize: CGFloat = 17.0
        let defaultAttribute = [
            NSForegroundColorAttributeName: Colors.greyColor(),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: fontSize)
        ]
        let matchAttribute = [
            NSForegroundColorAttributeName: Colors.mainColor(),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Bold, size: fontSize)
        ]
        
        let components = skill.name.lowercaseString.componentsSeparatedByString(searchString.lowercaseString)
        let fullString :NSMutableAttributedString = NSMutableAttributedString()
        for var i = 0; i < components.count; i++ {
            fullString.appendAttributedString(NSAttributedString(string: components[i], attributes: defaultAttribute))
            if (i != (components.count - 1)) { // last case
                fullString.appendAttributedString(NSAttributedString(string: searchString, attributes: matchAttribute))
            }
        }
        
        self.nameLabel.attributedText = fullString
        self.numberOfUsersLabel.text = "\(String(numberOfUsers))x"
    }
}
