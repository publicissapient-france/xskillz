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
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = (self.isHighlighted ? Colors.mainColor() : UIColor.white)
            self.updateNameLabel()
            self.numberOfUsersLabel.textColor = (self.isHighlighted ? UIColor.white : Colors.mainColor())
            self.separatorView.isHidden = self.isHighlighted
        }
    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = (self.isSelected ? Colors.mainColor() : UIColor.white)
            self.updateNameLabel()
            self.numberOfUsersLabel.textColor = (self.isSelected ? UIColor.white : Colors.mainColor())
            self.separatorView.isHidden = self.isSelected
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
    func skill(_ skill: Skill, searchString: String) -> Void {
        self.skill = skill
        self.searchString = searchString
        
        self.updateNameLabel()
        self.numberOfUsersLabel.text = "\(String(skill.numAllies))x"
    }
    
    
    // MARK: - Private API
    fileprivate func updateNameLabel() {
        var components = self.stringComponents((self.skill?.name)!, searchString: self.searchString!)
        let fullString: NSMutableAttributedString = NSMutableAttributedString()
        for i in 0 ..< components.count {
            fullString.append(NSAttributedString(string: components[i], attributes: (components[i].lowercased() == searchString!.lowercased()) ? self.skillNameMatchAttribute() : self.skillNameDefaultAttribute()))
        }
        
        self.nameLabel.attributedText = fullString
    }
    
    
    // MARK: - Helpers
    fileprivate func stringComponents(_ string: String, searchString: String) -> [String] {
        var components = [String]()
        var lastIndex: Int = 0
        
        for var i in 0 ..< string.characters.count {
            var part = string.substring(from: (string.characters.index(string.startIndex, offsetBy: i)))
            part = part.substring(to: string.characters.index(string.startIndex, offsetBy: min(part.characters.count, (self.searchString?.characters.count)!)))
            if (part.lowercased() == searchString.lowercased()) {
                if (components.count == 0 && i > 0) {
                    components.append(string.substring(to: string.characters.index(string.startIndex, offsetBy: i)))
                }
                else if (lastIndex < i) {
                    components.append(string.substring(from: string.characters.index(string.startIndex, offsetBy: lastIndex)).substring(to: string.characters.index(string.startIndex, offsetBy: i - lastIndex)))
                }
                components.append(part)
                lastIndex = (i + (self.searchString?.characters.count)!)
                i += ((self.searchString?.characters.count)! - 1)
            }
        }
        if (lastIndex < (string.characters.count)) {
            components.append(string.substring(from: string.characters.index(string.startIndex, offsetBy: lastIndex)))
        }
        
        return components
    }
    
    fileprivate func skillNameFontSize() -> CGFloat {
        return 17.0
    }
    
    fileprivate func skillNameDefaultAttribute() -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: (self.isHighlighted || self.isSelected ? UIColor.white : Colors.greyColor()),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.regular, size: self.skillNameFontSize())
        ]
    }
    
    fileprivate func skillNameMatchAttribute() -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: (self.isHighlighted || self.isSelected ? UIColor.white : Colors.mainColor()),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.bold, size: self.skillNameFontSize())
        ]
    }
}
