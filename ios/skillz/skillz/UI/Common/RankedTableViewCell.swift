//
//  RankedTableViewCell.swift
//  XSkillz
//
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class RankedTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var starsLightenBackgroundView: UIView!
    @IBOutlet weak var starsView: UIView!
    
    var collectionDataSource: UICollectionViewDataSource? {
        didSet {
            self.collectionView.dataSource = self.collectionDataSource
        }
    }
    var domain: Domain? {
        didSet {
            if (self.domain != nil) {
                self.mainBackgroundView.backgroundColor = self.domain!.colorObject
                self.starsView.backgroundColor = self.domain!.colorObject
            }
            else {
                // TODO: default colors
                self.mainBackgroundView.backgroundColor = UIColor.blackColor()
                self.starsView.backgroundColor = UIColor.blackColor()
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
    
    
    // MARK: - Init
    class func loadFromNib() -> RankedTableViewCell {
        return UINib(nibName: "RankedTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! RankedTableViewCell
    }
    
    // TODO: refacto cellHeight methods
    class func cellHeight(width: CGFloat, skills: [Skill]?) -> CGFloat {
        if skills == nil {
            return self.cellDefaultHeight()
        }
        
        let collectionViewWidth = (width - 30.0 - 5.0 - 5.0)
        var numberOfRows = 1
        var rowWidth: CGFloat = 0.0
        for skill in skills! {
            let cellWidth = min(SkillCollectionViewCell.cellSize(skill).width, width)
            rowWidth += cellWidth
            if (rowWidth > collectionViewWidth) {
                rowWidth = cellWidth
                numberOfRows += 1
            }
        }
        
        return (CGFloat(numberOfRows) * SkillCollectionViewCell.cellDefaultHeight())
    }
    
    class func cellHeight(width: CGFloat, users: [User]?) -> CGFloat {
        if users == nil {
            return self.cellDefaultHeight()
        }
        
        let collectionViewWidth = (width - 30.0 - 5.0 - 5.0)
        var numberOfRows = 1
        var rowWidth: CGFloat = 0.0
        for user in users! {
            let cellWidth = min(UserCollectionViewCell.cellSize(user).width, width)
            rowWidth += cellWidth
            if (rowWidth > collectionViewWidth) {
                rowWidth = cellWidth
                numberOfRows += 1
            }
        }
        
        return (CGFloat(numberOfRows) * UserCollectionViewCell.cellDefaultHeight())
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.backgroundColor = UIColor.clearColor()
        // TODO: refacto
        self.collectionView.registerNib(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkillCollectionViewCell")
        self.collectionView.registerNib(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 10.0, height: 40.0)
    }
}