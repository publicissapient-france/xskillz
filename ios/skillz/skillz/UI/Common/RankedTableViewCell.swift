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
            let height = self.collectionView.collectionViewLayout.collectionViewContentSize().height
            self.collectionViewHeightConstraint.constant = max(40.0, height)
        }
    }
    var domain: Domain? {
        didSet {
            if (self.domain != nil) {
                self.mainBackgroundView.backgroundColor = self.domain!.colorObject
                self.starsView.backgroundColor = self.domain!.colorObject
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
    
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.registerNib(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkillCollectionViewCell")
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 100.0, height: 40.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}