//
//  RankedTableViewCell.swift
//  XSkillz
//
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

typealias SkillSelectType = (_ skill: Skill?) -> Void
typealias UserSelectType = (_ user: User?) -> Void

class RankedTableViewCell: UITableViewCell, UICollectionViewDelegate {
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
                self.mainBackgroundView.backgroundColor = UIColor.black
                self.starsView.backgroundColor = UIColor.black
            }
        }
    }
    var estimatedItemSize: CGSize? {
        didSet {
            if estimatedItemSize != nil {
                self.collectionView.layoutIfNeeded() // iOS 10.x issue! WTF? Need to call layoutIfNeeded, if not collectionView make app crashing
                (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = self.estimatedItemSize!
            }
        }
    }
    var skill: Skill?
    var skillLevel: SkillLevel = .noSkill {
        didSet {
            let starsImage: UIImage!
            switch self.skillLevel {
            case .expert:
                starsImage = UIImage(named: "StarsExpert")
                self.starsLightenBackgroundView.alpha = 0.15
                
            case .confirmed:
                starsImage = UIImage(named: "StarsConfirmed")
                self.starsLightenBackgroundView.alpha = 0.30
                
            case .beginner:
                starsImage = UIImage(named: "StarsBeginner")
                self.starsLightenBackgroundView.alpha = 0.45
                
            default:
                starsImage = nil
                self.starsLightenBackgroundView.alpha = 0.60
            }
            self.starsImageView.image = starsImage
        }
    }
    var onSkillSelect: SkillSelectType?
    var onUserSelect: UserSelectType?
    
    
    // MARK: - Init
    class func loadFromNib() -> RankedTableViewCell {
        return UINib(nibName: "RankedTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RankedTableViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.estimatedItemSize = CGSize(width: 100.0, height: 40.0)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.delegate = self
        
        // TODO: refacto
        self.collectionView.register(UINib(nibName: "SkillCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkillCollectionViewCell")
        self.collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    
    
    // MARK: - Helpers
    // TODO: refacto cellHeight methods
    class func cellHeight(_ width: CGFloat, skills: [Skill]?) -> CGFloat {
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
    
    class func cellHeight(_ width: CGFloat, users: [User]?) -> CGFloat {
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
    
    
    // MARK: UICollectionViewDelegate
    // TODO: very ugly! Need to use protocols
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.collectionDataSource != nil {
            if self.collectionDataSource!.isKind(of: AllyRankedSkillsDataSource.self) {
                let skill = (self.collectionDataSource as! AllyRankedSkillsDataSource).skillFromIndexPath(indexPath)
                if self.onSkillSelect != nil {
                    // TODO: fix this... maybe we can update REST response to get domain?
                    let realm = try! RealmStore.defaultStore()
                    realm.beginWrite()
                    skill?.domain = self.domain
                    try! realm.commitWrite()
                    self.onSkillSelect!(skill!)
                }
            }
            else if self.collectionDataSource!.isKind(of: SkillRankedUsersDataSource.self) {
                let user = (self.collectionDataSource as! SkillRankedUsersDataSource).userFromIndexPath(indexPath)
                if self.onUserSelect != nil {
                    self.onUserSelect!(user!)
                }
            }
        }
    }
}
