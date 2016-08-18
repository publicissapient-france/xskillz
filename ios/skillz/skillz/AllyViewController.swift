//
//  AllyViewController.swift
//  skillz
//
//  Created by Florent Capon on 26/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var skillsCollectionView: UICollectionView!
    
    var ally: User!
    var loadingVisible: Bool! {
        didSet {
            if (self.loadingVisible == true) {
                self.loadingActivityIndicatorView.startAnimating()
            }
            else {
                self.loadingActivityIndicatorView.stopAnimating()
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
//        if #available(iOS 9, *) {
//            (self.skillsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
//        }
        self.usersStore.getFullUser(self.ally)
            .success { [weak self] (user:User) -> Void in
                self?.loadAvatar()
                self?.ally = user
                self?.skillsCollectionView.reloadData()
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
        return numberOfLevels
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let skillsRankedCell: SkillsRankedCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SkillsRankedCell", forIndexPath: indexPath) as! SkillsRankedCollectionViewCell
        let domain = self.domainFromSection(indexPath.section)
        let skills = self.skillsFromIndexPath(indexPath)
        skillsRankedCell.skillLevel = self.skillLevelFromIndexPath(indexPath)!
        skillsRankedCell.domain = domain
        skillsRankedCell.skills = skills
        return skillsRankedCell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let domain = self.domainFromSection(indexPath.section)
        let view: AllyDomainCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "AllyDomainCollectionReusableView", forIndexPath: indexPath) as! AllyDomainCollectionReusableView
        let numberOfSkills = domain?.skills.count
        let stringFormat = i18n(numberOfSkills > 1 ? "ally.number_of_skills.plural" : "ally.number_of_skills.singular")
        view.domain = domain
        view.numberOfResultsText = String(format: stringFormat, numberOfSkills!)
        return view
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellHeight = SkillsRankedCollectionViewCell.cellHeight(self.skillsFromIndexPath(indexPath), width: self.skillsCollectionView.bounds.size.width)
        return CGSizeMake(self.skillsCollectionView.bounds.size.width, cellHeight)
    }
    
    
    // MARK: - Helpers
    private func domainFromSection(section: Int) -> Domain? {
        if (self.ally != nil && section >= 0 && section < self.ally!.domains.count) {
            return self.ally!.domains[section]
        }
        return nil
    }
    
    private func skillLevelFromIndexPath(indexPath: NSIndexPath) -> SkillLevel! {
        let domain = self.domainFromSection(indexPath.section)
        let skills = domain!.skills
        var levels = [0, 0, 0, 0]
        for skill: Skill in skills {
            levels[(4 - skill.level)] += 1
        }
        var levelIndex = -1
        for i in 0 ..< levels.count {
            if (levels[i] > 0) {
                levelIndex += 1
            }
            if (levelIndex == indexPath.row) {
                return SkillLevel(rawValue: (4 - i))
            }
        }
        return SkillLevel.NoSkill
    }
    
    private func skillsFromIndexPath(indexPath: NSIndexPath) -> [Skill] {
        let domain = self.domainFromSection(indexPath.section)
        let skillLevel = self.skillLevelFromIndexPath(indexPath)
        let skills = domain!.skillsOfLevel(skillLevel)
        
        return skills
    }
    
    
    // MARK: - Actions
    @IBAction func actionClose() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}