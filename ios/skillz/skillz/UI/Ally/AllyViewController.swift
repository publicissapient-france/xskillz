//
//  AllyViewController.swift
//  skillz
//
//  Created by Florent Capon on 26/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    @IBOutlet weak var skillsTableView: UITableView!
    
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
    
    var interactor:Interactor? = nil
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerAvatarImageView.layer.mask = self.headerAvatarMaskImageView.layer
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        paragraphStyle.headIndent = 5.0
        let attributedString = NSMutableAttributedString(string: (self.ally.name.uppercaseString))
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.headerNameLabel.attributedText = attributedString
        self.headerCompanyLabel.text = self.ally.companyName.uppercaseString
        self.headerXPYearsLabel.text = String(self.ally.experienceCounter)
        self.skillsTableView.backgroundColor = UIColor.clearColor()
        self.skillsTableView.registerNib(UINib(nibName: "RankedTableViewCell", bundle: nil), forCellReuseIdentifier: "RankedTableViewCell")
        self.skillsTableView.registerNib(UINib(nibName: "DomainTitleCollectionView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DomainTitleCollectionView")
        self.usersStore.getFullUser(self.ally)
            .success { [weak self] (user:User) -> Void in
                self?.loadAvatar()
                self?.ally = user
                self?.skillsTableView.reloadData()
                self?.loadingVisible = false
        }
    }
    
    private func loadAvatar() -> Void {
        if (self.ally == nil) {
            return
        }
        UITableViewAutomaticDimension
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
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.ally.domains.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rankedCell: RankedTableViewCell = tableView.dequeueReusableCellWithIdentifier("RankedTableViewCell", forIndexPath: indexPath) as! RankedTableViewCell
        let domain = self.domainFromSection(indexPath.section)
        let skills = self.skillsFromIndexPath(indexPath)
        rankedCell.skillLevel = self.skillLevelFromIndexPath(indexPath)!
        rankedCell.domain = domain
        rankedCell.collectionDataSource = AllyRankedSkillsDataSource(domain: domain, skills: skills)
        
        return rankedCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let skills = self.skillsFromIndexPath(indexPath)
        let cellHeight = RankedTableViewCell.cellHeight(tableView.bounds.size.width, skills: skills)
        return cellHeight
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let domain = self.domainFromSection(section)
        let view: DomainTitleCollectionView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("DomainTitleCollectionView") as! DomainTitleCollectionView
        let numberOfSkills = domain?.skills.count
        let stringFormat = i18n(numberOfSkills > 1 ? "ally.number_of_skills.plural" : "ally.number_of_skills.singular")
        view.domain = domain
        view.numberOfResultsText = String(format: stringFormat, numberOfSkills!)
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0 ? DomainTitleCollectionView.defaultHeight() : DomainTitleCollectionView.defaultHeightWithSpacing())
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
            levels[(3 - skill.level)] += 1
        }
        var levelIndex = -1
        for i in 0 ..< levels.count {
            if (levels[i] > 0) {
                levelIndex += 1
            }
            if (levelIndex == indexPath.row) {
                return SkillLevel(rawValue: (3 - i))
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
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translationInView(view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .Began:
            interactor.hasStarted = true
            dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.updateInteractiveTransition(progress)
        case .Cancelled:
            interactor.hasStarted = false
            interactor.cancelInteractiveTransition()
        case .Ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finishInteractiveTransition()
                : interactor.cancelInteractiveTransition()
        default:
            break
        }
    }
}