//
//  UsersRankedCollectionViewCell.swift
//  XSkillz
//
//  Created by Florent Capon on 11/08/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import SnapKit

class UsersRankedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var starsBackgroundView: UIView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var starsLightenBackgroundView: UIView!
    @IBOutlet weak var usersContentView: UIView!
    
    var domain: Domain? {
        didSet {
            if (self.domain != nil) {
                self.mainBackgroundView.backgroundColor = self.domain!.colorObject
                self.starsBackgroundView.backgroundColor = self.domain!.colorObject
            }
            else {
                // TODO : default colors
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
    var users: [User]! {
        didSet {
            var userView: UserView
            for subView in self.usersContentView.subviews {
                userView = subView as! UserView
                userView.button.removeTarget(self, action: #selector(userAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                userView.removeFromSuperview()
            }
            userViews = []
            
            for user: User in self.users {
                userView = UserView.loadFromNib()
                userView.user = user
                userView.like = user.isInterestedBySkill(self.skill)
                userView.loadAvatar()
                if (self.domain != nil) {
                    userView.color = self.domain!.colorObject
                }
                userView.button.addTarget(self, action: #selector(userAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                self.usersContentView.addSubview(userView)
                self.userViews.append(userView)
            }
        }
    }
    var userSelected: ((User) -> (Void))?
    var userViews: [UserView] = []
    
    
    // MARK: - Class functions
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
    
    class func layoutUserViews(userViews: [UserView]!) -> CGFloat { // returns total height
        let spacing: CGFloat = 20.0
        
        var currentX: CGFloat = 0.0
        var currentY: CGFloat = 0.0
        var userViewSize: CGSize = CGSize(width: 0.0, height: 0.0)
        
        for userView: UserView in userViews {
            userViewSize = userView.sizeFitting()
            if ((currentX + userViewSize.width) > userView.superview!.bounds.size.width) {
                // new line
                currentX = 0.0
                currentY += UsersRankedCollectionViewCell.cellDefaultHeight()
            }
            
            userView.snp_remakeConstraints(closure: { (make) in
                make.width.equalTo(userViewSize.width)
                make.height.equalTo(userViewSize.height)
                make.top.equalTo(userView.superview!).offset(currentY)
                make.left.equalTo(userView.superview!).offset(currentX)
            })
            
            currentX += (userViewSize.width + spacing)
        }
        
        return (currentY + userViewSize.height)
    }
    
    class func cellHeight(users: [User]!, width: CGFloat) -> CGFloat {
        if users.count == 0 {
            return 0.0
        }
        
        let usersContentWidth = (width - 30.0 - 10.0 - 10.0) // starsImage width + left padding + right padding
        let contentView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: usersContentWidth, height: 100.0))
        
        var userView: UserView
        for user: User in users {
            userView = UserView.loadFromNib()
            userView.user = user
            contentView.addSubview(userView)
        }
        
        let totalHeight = UsersRankedCollectionViewCell.layoutUserViews(contentView.subviews as! [UserView])
        return max(UsersRankedCollectionViewCell.cellDefaultHeight(), (totalHeight + 8.0 + 8.0)) // top padding + bottom padding
    }
    
    class private func isUserViewOutOfBounds(userView: UserView) -> Bool {
        return (userView.frame.origin.x + userView.frame.size.width) > userView.superview!.bounds.size.width
    }
    
    
    // MARK: - Init
    override func prepareForReuse() {
        self.users = []
    }
    
    
    // MARK: - UI
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UsersRankedCollectionViewCell.layoutUserViews(self.userViews)
    }
    
    
    // MARK: - Actions
    func userAction(sender: UIButton) {
        let userView: UserView = sender.superview as! UserView
        let user: User = userView.user
        if (self.userSelected != nil) {
            self.userSelected!(user)
        }
    }
}
