//
//  AllySkillsCollectionViewCell.swift
//  skillz
//
//  Created by Florent Capon on 11/02/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllySkillsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundColorView: UIView!
    
    var skillViews: [SkillView] = []
    var skillSelected: ((Skill) -> (Void))?
    
    var skills: [Skill]! {
        didSet {
            var skillView: SkillView;
            for skill: Skill in self.skills {
                skillView = SkillView.loadFromNib()
                skillView.skill = skill
                skillView.button.addTarget(self, action: Selector("skillAction:"), forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(skillView);
                self.skillViews.append(skillView)
            }
        }
    }
    var domain: Domain! {
        didSet {
            self.backgroundColorView.backgroundColor = self.domain.colorObject()
        }
    }
    
    class func cellHeight(skills: [Skill], forWidth: CGFloat) -> CGFloat {
        return self.cellDefaultHeight()*3.0
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 23.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for subview: UIView in self.skillViews {
            subview.removeFromSuperview()
        }
        self.skillViews = []
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frameRect: CGRect = CGRectZero
        var currentX: CGFloat = 0.0
        var currentY: CGFloat = 0.0
        var lineWidth: CGFloat = 0.0
        let spacing: CGFloat = 20.0
        var firstItemOfNewLine: Bool = false
        var skillViewsToCenter: [SkillView] = []
        for skillView: SkillView in self.skillViews {
            skillView.sizeToFit()
            frameRect = skillView.frame
            frameRect.origin.x = currentX
            frameRect.origin.y = currentY
            skillView.frame = frameRect
            firstItemOfNewLine = false
            if (self.isSkillViewOutOfBounds(skillView)) {
                // new line
                firstItemOfNewLine = true
                currentX = 0.0
                currentY += AllySkillsCollectionViewCell.cellDefaultHeight()
                frameRect.origin.x = currentX
                frameRect.origin.y = currentY
                skillView.frame = frameRect
                self.centerSkillViews(skillViewsToCenter, lineWidth: (lineWidth - spacing))
                skillViewsToCenter = []
                skillViewsToCenter.append(skillView)
                lineWidth = (frameRect.size.width + spacing)
            }
            else {
                skillViewsToCenter.append(skillView)
                lineWidth += (frameRect.size.width + spacing)
            }
            currentX += (frameRect.size.width + spacing)
        }
        lineWidth -= spacing
        self.centerSkillViews(skillViewsToCenter, lineWidth: lineWidth)
    }
    
    func cellHeight() -> CGFloat {
        if (self.skillViews.count > 0) {
            let skillView: SkillView = self.skillViews.last!
            return (skillView.frame.origin.y + skillView.frame.size.height + 10.0)
        }
        return AllySkillsCollectionViewCell.cellDefaultHeight()
    }
    
    private func isSkillViewOutOfBounds(skillView: SkillView) -> Bool {
        return (skillView.frame.origin.x + skillView.frame.size.width + 20.0) > self.bounds.size.width
    }
    
    private func centerSkillViews(skillViews: [SkillView], lineWidth: CGFloat) {
        let padding: CGFloat = ((self.bounds.size.width - lineWidth) / 2.0)
        let spacing: CGFloat = 20.0
        var frameRect: CGRect = CGRectZero
        var currentX: CGFloat = padding
        for skillView: UIView in skillViews {
            frameRect = skillView.frame
            frameRect.origin.x = currentX
            currentX += (frameRect.size.width + spacing)
            skillView.frame = frameRect
        }
    }
    
    func skillAction(sender: UIButton) {
        let skillView: SkillView = sender.superview as! SkillView
        let skill: Skill = skillView.skill
        self.skillSelected!(skill)
    }
}
