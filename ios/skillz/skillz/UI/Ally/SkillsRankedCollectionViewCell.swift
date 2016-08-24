//
//  SkillsRankedCollectionViewCell.swift
//  XSkillz
//
//  Created by Florent Capon on 11/08/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import SnapKit

class SkillsRankedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var starsBackgroundView: UIView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var starsLightenBackgroundView: UIView!
    @IBOutlet weak var skillsContentView: UIView!
    
    var domain: Domain? {
        didSet {
            if (self.domain != nil) {
                self.mainBackgroundView.backgroundColor = self.domain!.colorObject
                self.starsBackgroundView.backgroundColor = self.domain!.colorObject
            }
            else {
                // TODO: default colors
            }
        }
    }
    var skill: Skill?
    var skillLevel: SkillLevel = .NoSkill {
        didSet {
            let starsImage: UIImage!
            switch self.skillLevel {
            case .Expert:
                starsImage = UIImage(named: "StarsExpert")
                self.starsLightenBackgroundView.alpha = 0.15
                
            case .Confirmed:
                starsImage = UIImage(named: "StarsConfirmed")
                self.starsLightenBackgroundView.alpha = 0.30
                
            case .Beginner:
                starsImage = UIImage(named: "StarsBeginner")
                self.starsLightenBackgroundView.alpha = 0.45
                
            default:
                starsImage = nil
                self.starsLightenBackgroundView.alpha = 0.60
            }
            self.starsImageView.image = starsImage
        }
    }
    var skills: [Skill]! {
        didSet {
            var skillView: SkillView
            for subView in self.skillsContentView.subviews {
                skillView = subView as! SkillView
                skillView.button.removeTarget(self, action: #selector(skillAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                skillView.removeFromSuperview()
            }
            self.skillViews = []
            
            for skill: Skill in self.skills {
                skillView = SkillView.loadFromNib()
                skillView.skill = skill
                skillView.color = self.domain!.colorObject
                skillView.button.addTarget(self, action: #selector(skillAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                self.skillsContentView.addSubview(skillView)
                self.skillViews.append(skillView)
            }
        }
    }
    var skillSelected: ((Skill) -> (Void))?
    var skillViews: [SkillView] = []
    
    
    // MARK: - Class functions
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
    
    class func layoutSkillViews(skillViews: [SkillView]!) -> CGFloat { // returns total height
        let spacing: CGFloat = 20.0
        
        var currentX: CGFloat = 0.0
        var currentY: CGFloat = 0.0
        var skillViewSize: CGSize = CGSize(width: 0.0, height: 0.0)
        
        for skillView: SkillView in skillViews {
            skillViewSize = skillView.sizeFitting()
            if ((currentX + skillViewSize.width) > skillView.superview!.bounds.size.width) {
                // new line
                currentX = 0.0
                currentY += SkillsRankedCollectionViewCell.cellDefaultHeight()
            }
            
            skillView.snp_remakeConstraints(closure: { (make) in
                make.width.equalTo(skillViewSize.width)
                make.height.equalTo(skillViewSize.height)
                make.top.equalTo(skillView.superview!).offset(currentY)
                make.left.equalTo(skillView.superview!).offset(currentX)
            })
            
            currentX += (skillViewSize.width + spacing)
        }
        
        return (currentY + skillViewSize.height)
    }
    
    class func cellHeight(skills: [Skill]!, width: CGFloat) -> CGFloat {
        if skills.count == 0 {
            return 0.0
        }
        
        let skillsContentWidth = (width - 30.0 - 10.0 - 10.0) // starsImage width + left padding + right padding
        let contentView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: skillsContentWidth, height: 100.0))
        
        var skillView: SkillView
        for skill: Skill in skills {
            skillView = SkillView.loadFromNib()
            skillView.skill = skill
            contentView.addSubview(skillView)
        }
        
        let totalHeight = SkillsRankedCollectionViewCell.layoutSkillViews(contentView.subviews as! [SkillView])
        return max(SkillsRankedCollectionViewCell.cellDefaultHeight(), (totalHeight + 8.0 + 8.0)) // top padding + bottom padding
    }
    
    
    // MARK: - Init
    override func prepareForReuse() {
        self.skills = []
    }
    
    
    // MARK: - UI
    override func layoutSubviews() {
        super.layoutSubviews()
        
        SkillsRankedCollectionViewCell.layoutSkillViews(self.skillViews)
    }
    
    
    // MARK: - Actions
    func skillAction(sender: UIButton) {
        let skillView: SkillView = sender.superview as! SkillView
        let skill: Skill = skillView.skill
        if (self.skillSelected != nil) {
            self.skillSelected!(skill)
        }
    }
}
