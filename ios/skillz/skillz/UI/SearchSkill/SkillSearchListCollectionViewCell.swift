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
            self.numberOfUsersLabel.textColor = (self.highlighted ? UIColor.whiteColor() : Colors.mainColor())
            self.separatorView.hidden = self.highlighted
        }
    }
    override var selected: Bool {
        didSet {
            self.backgroundColor = (self.selected ? Colors.mainColor() : UIColor.whiteColor())
            self.updateNameLabel()
            self.numberOfUsersLabel.textColor = (self.selected ? UIColor.whiteColor() : Colors.mainColor())
            self.separatorView.hidden = self.selected
        }
    }
    
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.text = nil
        self.numberOfUsersLabel.text = nil
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 30.0
    }
    
    
    // MARK: - Public API
    func skill(skill: Skill, searchString: String) -> Void {
        self.skill = skill
        self.searchString = searchString
        
        self.updateNameLabel()
        self.numberOfUsersLabel.text = "\(String(skill.numAllies))x"
    }
    
    
    // MARK: - Private API
    private func updateNameLabel() {
        var components = self.stringComponents((self.skill?.name)!, searchString: self.searchString!)
        let fullString: NSMutableAttributedString = NSMutableAttributedString()
        for var i = 0; i < components.count; i++ {
            fullString.appendAttributedString(NSAttributedString(string: components[i], attributes: (components[i].lowercaseString == searchString!.lowercaseString) ? self.skillNameMatchAttribute() : self.skillNameDefaultAttribute()))
        }
        
        self.nameLabel.attributedText = fullString
    }
    
    
    // MARK: - Helpers
    private func stringComponents(string: String, searchString: String) -> [String] {
        var components = [String]()
        var lastIndex: Int = 0
        
        for var i = 0; i < string.characters.count; i++ {
            var part = string.substringFromIndex((string.startIndex.advancedBy(i)))
            part = part.substringToIndex(string.startIndex.advancedBy(min(part.characters.count, (self.searchString?.characters.count)!)))
            if (part.lowercaseString == searchString.lowercaseString) {
                if (components.count == 0 && i > 0) {
                    components.append(string.substringToIndex(string.startIndex.advancedBy(i)))
                }
                else if (lastIndex < i) {
                    components.append(string.substringFromIndex(string.startIndex.advancedBy(lastIndex)).substringToIndex(string.startIndex.advancedBy(i - lastIndex)))
                }
                components.append(part)
                lastIndex = (i + (self.searchString?.characters.count)!)
                i += ((self.searchString?.characters.count)! - 1)
            }
        }
        if (lastIndex < (string.characters.count)) {
            components.append(string.substringFromIndex(string.startIndex.advancedBy(lastIndex)))
        }
        
        return components
    }
    
    private func skillNameFontSize() -> CGFloat {
        return 17.0
    }
    
    private func skillNameDefaultAttribute() -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: (self.highlighted || self.selected ? UIColor.whiteColor() : Colors.greyColor()),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: self.skillNameFontSize())
        ]
    }
    
    private func skillNameMatchAttribute() -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: (self.highlighted || self.selected ? UIColor.whiteColor() : Colors.mainColor()),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Bold, size: self.skillNameFontSize())
        ]
    }
}
