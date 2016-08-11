//
//  UsersRankedCollectionViewCell.swift
//  XSkillz
//
//  Created by Florent Capon on 11/08/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class UsersRankedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var starsBackgroundView: UIView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var starsLightenBackgroundView: UIView!
    @IBOutlet weak var usersContentView: UIView!
    
    var domain: Domain! {
        didSet {
            self.mainBackgroundView.backgroundColor = self.domain.colorObject
            self.starsBackgroundView.backgroundColor = self.domain.colorObject
        }
    }
    var rank: Int = 0 {
        didSet {
            let starsImage: UIImage!
            switch self.rank {
            case 3:
                starsImage = UIImage(named: "StarsExpert")
                self.starsLightenBackgroundView.alpha = 0.15
                
            case 2:
                starsImage = UIImage(named: "StarsConfirmed")
                self.starsLightenBackgroundView.alpha = 0.30
                
            case 1:
                starsImage = UIImage(named: "StarsBeginner")
                self.starsLightenBackgroundView.alpha = 0.45
                
            default:
                starsImage = nil
                self.starsLightenBackgroundView.alpha = 0.60
            }
            self.starsImageView.image = starsImage
        }
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
}
