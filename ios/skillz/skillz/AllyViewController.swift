//
//  AllyViewController.swift
//  skillz
//
//  Created by Florent Capon on 26/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

enum CellType : Int {
    case Unknown
    case Level
    case Skill
}

class AllyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var headerLineView: UIView!
    @IBOutlet weak var headerAvatarView: UIView!
    @IBOutlet weak var headerAvatarImageView: UIImageView!
    @IBOutlet weak var headerAvatarMaskImageView: UIImageView!
    @IBOutlet weak var headerAvatarBackgroundImageView: UIImageView!
    @IBOutlet weak var headerAvatarActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var headerCompanyLabel: UILabel!
    @IBOutlet weak var headerXPView: UIView!
    @IBOutlet weak var headerXPYearsLabel: UILabel!
    @IBOutlet weak var headerXPLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var skillsCollectionView: UICollectionView!
    
    var ally: User!
    var loadingVisible: Bool! {
        didSet {
            if (self.loadingVisible == true) {
                self.loadingView.startAnimating()
            }
            else {
                self.loadingView.stopAnimating()
            }
        }
    }
    var usersStore: UsersStore!

    
    // MARK: - Init
    deinit {
        self.skillsCollectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerAvatarImageView.layer.mask = self.headerAvatarMaskImageView.layer
        self.headerNameLabel.text = self.ally.name.uppercaseString
        self.headerCompanyLabel.text = self.ally.companyName.uppercaseString
        self.headerXPYearsLabel.text = String(self.ally.experienceCounter)
        self.usersStore.getFullUser(self.ally)
            .success { [weak self] (user:User) -> Void in
                self?.loadAvatar()
                self?.ally = user
//                self?.skillsCollectionView.reloadData()
                self?.loadingVisible = false
        }
    }
    
    private func loadAvatar() -> Void {
        if (self.ally == nil) {
            return
        }
        
        self.headerAvatarActivityIndicatorView.startAnimating()
        self.headerAvatarImageView.af_setImageWithURL(NSURL(string: (self.ally.gravatarUrl))!,
            placeholderImage: nil,
            filter: nil,
            imageTransition: UIImageView.ImageTransition.None,
            completion:{ [weak self] response in
                self?.headerAvatarActivityIndicatorView.stopAnimating()
            }
        )
    }
    
    
    // MARK: - Delegates
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.ally.domains.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let skills = self.domainFromSection(section)?.skills
        var levels = [0, 0, 0, 0]
        var numberOfLevels = 0
        for skill: Skill in skills! {
            if (levels[skill.level] == 0) {
                numberOfLevels += 1
            }
            levels[skill.level] = 1
        }
        return (numberOfLevels * 2)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch self.cellTypeFromIndexPath(indexPath) {
        case CellType.Level:
            let cell: SkillStarsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SkillStarsCell", forIndexPath: indexPath) as! SkillStarsCollectionViewCell
            cell.level = SkillLevel.Expert
            cell.level = self.levelFromIndexPath(indexPath)
            cell.domain = self.domainFromSection(indexPath.section)
            return cell
            
        case CellType.Skill:
            let cell: AllySkillsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("AllySkillsCell", forIndexPath: indexPath) as! AllySkillsCollectionViewCell
            cell.skills = self.skillsFromIndexPath(indexPath);
            cell.domain = self.domainFromSection(indexPath.section)
            cell.skillSelected = { [weak self] (skill: Skill) -> () in
                // TODO
            }
            return cell
            
        case CellType.Unknown:
            return UICollectionViewCell()
        }
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            switch self.cellTypeFromIndexPath(indexPath) {
            case CellType.Level:
                return CGSizeMake(self.skillsCollectionView.bounds.size.width, SkillStarsCollectionViewCell.cellDefaultHeight())
                
            case CellType.Skill:
                //            let cell = self.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! SkillCollectionViewCell
                //            return CGSizeMake(cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width, SkillCollectionViewCell.cellDefaultHeight())
                let cellTemp: AllySkillsCollectionViewCell = AllySkillsCollectionViewCell()
                cellTemp.frame = CGRectMake(0.0, 0.0, self.skillsCollectionView.bounds.size.width, 100.0)
                cellTemp.skills = self.skillsFromIndexPath(indexPath)
                cellTemp.layoutSubviews()
                return CGSizeMake(self.skillsCollectionView.bounds.size.width, cellTemp.cellHeight())
                
            case CellType.Unknown:
                return CGSizeZero
            }
    }
    
    
    // MARK: - Helpers
    private func cellTypeFromIndexPath(indexPath: NSIndexPath) -> CellType {
        let skills = self.domainFromSection(indexPath.section)?.skills
        var noSkillSkills = [Skill]()
        var beginnerSkills = [Skill]()
        var confirmedSkills = [Skill]()
        var expertSkills = [Skill]()
        for skill: Skill in skills! {
            switch skill.skillLevel {
            case SkillLevel.NoSkill:
                noSkillSkills.append(skill)
                break
                
            case SkillLevel.Beginner:
                beginnerSkills.append(skill)
                break
                
            case SkillLevel.Confirmed:
                confirmedSkills.append(skill)
                break
                
            case SkillLevel.Expert:
                expertSkills.append(skill)
                break
            }
        }
        let allSkillsLevels = [expertSkills, confirmedSkills, beginnerSkills, noSkillSkills]
        var index = 0
        for skillsLevel: [Skill] in allSkillsLevels {
            if (skillsLevel.count > 0) {
                if (index == indexPath.row) {
                    return CellType.Level
                }
                index += 1
                if (index == indexPath.row) {
                    return CellType.Skill
                }
                index += 1
            }
        }
        return CellType.Unknown
    }
    
    private func domainFromSection(section: Int) -> Domain? {
        if (self.ally != nil && section >= 0 && section < self.ally!.domains.count) {
            return self.ally!.domains[section]
        }
        return nil
    }
    
    private func levelFromIndexPath(indexPath: NSIndexPath) -> SkillLevel? {
        return SkillLevel(rawValue: (self.dataFromIndexPath(indexPath) as! NSNumber).integerValue)
    }
    
    private func skillsFromIndexPath(indexPath: NSIndexPath) -> [Skill]? {
        return self.dataFromIndexPath(indexPath) as? [Skill]
    }
    
    private func dataFromIndexPath(indexPath: NSIndexPath) -> AnyObject? {
        let skills = self.domainFromSection(indexPath.section)?.skills
        var noSkillSkills = [Skill]()
        var beginnerSkills = [Skill]()
        var confirmedSkills = [Skill]()
        var expertSkills = [Skill]()
        for skill: Skill in skills! {
            switch skill.skillLevel {
            case SkillLevel.NoSkill:
                noSkillSkills.append(skill)
                break
                
            case SkillLevel.Beginner:
                beginnerSkills.append(skill)
                break
                
            case SkillLevel.Confirmed:
                confirmedSkills.append(skill)
                break
                
            case SkillLevel.Expert:
                expertSkills.append(skill)
                break
            }
        }
        let allSkillsLevels = [expertSkills, confirmedSkills, beginnerSkills, noSkillSkills]
        var index = 0
        for skillsLevel: [Skill] in allSkillsLevels {
            if (skillsLevel.count > 0) {
                if (index == indexPath.row) {
                    return NSNumber(integer: skillsLevel[0].level)
                }
                index += 1
                if (index == indexPath.row) {
                    return skillsLevel
                }
                index += 1
            }
        }
        return nil
    }
    
    
    // MARK: - Actions
    @IBAction func actionClose() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}