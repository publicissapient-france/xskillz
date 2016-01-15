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
    
    var skill: Skill?
    var searchString: String?
    
    override var highlighted: Bool {
        didSet {
            self.backgroundColor = (self.highlighted ? Colors.mainColor() : UIColor.whiteColor())
            self.updateNameLabel()
            self.numberOfUsersLabel.textColor = (self.highlighted ? UIColor.whiteColor() : Colors.greyColor())
            self.separatorView.hidden = self.highlighted
        }
    }
    override var selected: Bool {
        didSet {
            self.backgroundColor = (self.selected ? Colors.mainColor() : UIColor.whiteColor())
            self.updateNameLabel()
            self.numberOfUsersLabel.textColor = (self.selected ? UIColor.whiteColor() : Colors.greyColor())
            self.separatorView.hidden = self.selected
        }
    }
    
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
        self.skill = skill
        self.searchString = searchString
        
        self.updateNameLabel()
        self.numberOfUsersLabel.text = "\(String(numberOfUsers))x"
    }
    
    func updateNameLabel() {
        let fontSize: CGFloat = 17.0
        let defaultAttribute = [
            NSForegroundColorAttributeName: (self.highlighted || self.selected ? UIColor.whiteColor() : Colors.greyColor()),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: fontSize)
        ]
        let matchAttribute = [
            NSForegroundColorAttributeName: (self.highlighted || self.selected ? UIColor.whiteColor() : Colors.mainColor()),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Bold, size: fontSize)
        ]
        
        let name = self.skill?.name
        var components = [String]()
        var lastIndex: Int = 0
        
        for var i = 0; i < name?.characters.count; i++ {
            var part = name?.substringFromIndex((name?.startIndex.advancedBy(i))!)
            part = part!.substringToIndex(name!.startIndex.advancedBy(min(part!.characters.count, (self.searchString?.characters.count)!)))
            if (part!.lowercaseString == searchString?.lowercaseString) {
                if (components.count == 0 && i > 0) {
                    components.append(name!.substringToIndex(name!.startIndex.advancedBy(i)))
                }
                else if (lastIndex < i) {
                    components.append(name!.substringFromIndex(name!.startIndex.advancedBy(lastIndex)).substringToIndex(name!.startIndex.advancedBy(i - lastIndex)))
                }
                components.append(part!)
                lastIndex = (i + (self.searchString?.characters.count)!)
                i += ((self.searchString?.characters.count)! - 1)
            }
        }
        if (lastIndex < (name!.characters.count)) {
            components.append(name!.substringFromIndex(name!.startIndex.advancedBy(lastIndex)))
        }
        
        let fullString :NSMutableAttributedString = NSMutableAttributedString()
        for var i = 0; i < components.count; i++ {
            fullString.appendAttributedString(NSAttributedString(string: components[i], attributes: (components[i].lowercaseString == searchString!.lowercaseString) ? matchAttribute : defaultAttribute))
        }
        
        self.nameLabel.attributedText = fullString
    }
}
