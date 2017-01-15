//
//  SearchSkillViewController.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask

class SearchSkillViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var skillsResultsListTableView: UITableView!
    @IBOutlet weak var skillsResultsListWrapperView: UIView!
    @IBOutlet weak var skillsSearchListCollectionView: UICollectionView!
    @IBOutlet weak var skillsSearchListCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skillsSearchListWrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let interactor = Interactor()
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
    var numberOfUsers: Int {
        get {
            if (self.users != nil) {
                return self.users![0].count + self.users![1].count + self.users![2].count + self.users![3].count
            }
            return 0
        }
    }
    var searchString: String?
    var selectedSkill: Skill?
    var skillsStore: SkillsStore = SkillsStore.sharedInstance
    var usersStore: UsersStore = UsersStore.sharedInstance
    var skills: [Skill]?
    var users: [[User]]?
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.font = Fonts.screenTitleFont()
        self.titleLabel.text = i18n("search_skill.title").uppercased()
        self.searchTextField.placeholder = i18n("search_skill.textfield.placeholder")
        self.skillsResultsListTableView.backgroundColor = UIColor.clear
        self.skillsResultsListTableView.register(UINib(nibName: "RankedTableViewCell", bundle: nil), forCellReuseIdentifier: "RankedTableViewCell")
        self.skillsResultsListTableView.register(UINib(nibName: "DomainTitleCollectionView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DomainTitleCollectionView")
    }
    
    
    // MARK: - Search
    fileprivate func updateSearch(_ search: String) {
        self.loadingVisible = true
        self.users = nil
        self.skillsResultsListTableView.reloadData()
        self.searchString = search
        self.skillsStore.getSkillsFromSearch(search)
            .success { [weak self] (skills:[Skill]) -> Void in
                self?.loadingVisible = false
                self?.skills = skills
                self?.skillsSearchListCollectionView.reloadData()
                Timer.scheduledTimer(timeInterval: 0.05, target: self!, selector: #selector(SearchSkillViewController.resizeSearchListCollection), userInfo: nil, repeats: false)
                
        }
    }
    
    func resizeSearchListCollection() -> Void {
        self.skillsSearchListCollectionViewHeightConstraint.constant = min((self.skillsSearchListCollectionView.contentSize.height), 210.0)
    }
    
    
    // MARK: - Results
    func selectSkill(_ skill: Skill) -> Void {
        self.loadingVisible = true
        self.selectedSkill = skill
        self.searchTextField.text = skill.name
        self.searchTextField.resignFirstResponder()
        self.skillsSearchListWrapperView.isHidden = true
        self.skillsStore.getAllUsersForSkill(skill)
            .success { [weak self] (users:[User]) -> FullUsersTask in
                return (self?.usersStore.getFullUsers(users))!
            }
            .success { [weak self] (users:[User]) -> Void in
                self?.orderUsers(users)
                self?.skillsResultsListTableView.reloadData()
                self?.loadingVisible = false
        }
    }
    
    fileprivate func orderUsers(_ users: [User]) -> Void {
        var noSkillUsers = [User]()
        var beginnerUsers = [User]()
        var confirmedUsers = [User]()
        var expertUsers = [User]()
        for user: User in users {
            for domain:Domain in user.domains {
                for skill:Skill in domain.skills {
                    if (skill.id == self.selectedSkill!.id) {
                        switch skill.skillLevel {
                        case SkillLevel.noSkill:
                            noSkillUsers.append(user)
                            break
                            
                        case SkillLevel.beginner:
                            beginnerUsers.append(user)
                            break
                            
                        case SkillLevel.confirmed:
                            confirmedUsers.append(user)
                            break
                            
                        case SkillLevel.expert:
                            expertUsers.append(user)
                            break
                        }
                    }
                }
            }
        }
        self.users = [expertUsers, confirmedUsers, beginnerUsers, noSkillUsers]
    }
    
    
    // MARK: - Navigation
    fileprivate func selectAlly(_ ally: User) -> Void {
        self.performSegue(withIdentifier: "ShowAlly", sender: ally)
    }
    
    
    // MARK: - Delegates
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newString:NSString = textField.text! as NSString
        newString = newString.replacingCharacters(in: range, with: string) as NSString
        self.updateSearch(newString as String)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.updateSearch("")
        return true
    }
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.skillsSearchListWrapperView.isHidden = true
        if (self.searchString == nil || self.searchString!.characters.count < 2) {
            return 0
        }
        if (self.skills != nil) {
            self.skillsSearchListWrapperView.isHidden = (self.skills?.count == 0)
            return self.skills!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let skill: Skill = self.skillFromIndexPath(indexPath)!
        let skillCell: SkillSearchListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillSearchListCell", for: indexPath) as! SkillSearchListCollectionViewCell
        skillCell.skill(skill, searchString: self.searchString!)
        
        return skillCell
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectSkill(self.skillFromIndexPath(indexPath)!)
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.skillsSearchListCollectionView.bounds.size.width, height: SkillSearchListCollectionViewCell.cellDefaultHeight())
    }
    
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return (self.users != nil ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfSkillsLevels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let domain = self.selectedSkill!.domain
        let users = self.usersForSkillFromIndexPath(indexPath)
        let rankedCell: RankedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RankedTableViewCell", for: indexPath) as! RankedTableViewCell
        
        rankedCell.estimatedItemSize = CGSize(width: 100.0, height: RankedTableViewCell.cellDefaultHeight())
        rankedCell.skillLevel = self.skillLevelFromIndexPath(indexPath)!
        rankedCell.domain = domain
        rankedCell.collectionDataSource = SkillRankedUsersDataSource(domain: domain, users: users)
        rankedCell.onUserSelect = { [weak self] (user) in
            self?.selectAlly(user!)
        }
        
        return rankedCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let users = self.usersForSkillFromIndexPath(indexPath)
        let cellHeight = RankedTableViewCell.cellHeight(tableView.bounds.size.width, users: users)
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let domain = self.selectedSkill!.domain
        let numberOfUsers = self.numberOfUsers
        let stringFormat = i18n(numberOfUsers > 1 ? "search_skill.number_of_allies.plural" : "search_skill.number_of_allies.singular")
        let view: DomainTitleCollectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DomainTitleCollectionView") as! DomainTitleCollectionView
        
        view.domain = domain
        view.numberOfResultsText = String(format: stringFormat, numberOfUsers)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0 ? DomainTitleCollectionView.defaultHeight() : DomainTitleCollectionView.defaultHeightWithSpacing())
    }
    
    
    // MARK: - Helpers
    fileprivate func numberOfSkillsLevels() -> Int {
        if self.users == nil {
            return 0
        }
        var value = 0
        for skillUsers:[User] in self.users! {
            if skillUsers.count > 0 {
                value += 1
            }
        }
        return value
    }
    
    fileprivate func skillFromIndexPath(_ indexPath: IndexPath) -> Skill? {
        if (self.skills != nil) {
            return self.skills![indexPath.row]
        }
        return nil
    }
    
    fileprivate func skillLevelFromIndexPath(_ indexPath: IndexPath) -> SkillLevel! {
        var skillLevelIndex = SkillLevel.expert.rawValue
        var index = 0
        for i in 0 ..< 4 {
            if (self.users![i].count == 0) {
                skillLevelIndex -= 1
                continue
            }
            if (index == indexPath.row) {
                return SkillLevel(rawValue: skillLevelIndex)
            }
            skillLevelIndex -= 1
            index += 1
        }
        return SkillLevel.noSkill
    }
    
    fileprivate func usersForSkillFromIndexPath(_ indexPath: IndexPath) -> [User]? {
        var index = -1
        for skillUsers:[User] in self.users! {
            if skillUsers.count > 0 {
                index += 1
            }
            if index == indexPath.row {
                return skillUsers
            }
        }
        return nil
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "ShowAlly":
            let viewController = segue.destination as! AllyViewController
            viewController.transitioningDelegate = self
            viewController.interactor = self.interactor
            viewController.ally = sender as! User
            viewController.onSkillSelect = { [weak self] (skill) in
                self?.selectSkill(skill!)
            }
            break
            
        default:
            break
        }
    }
}

extension SearchSkillViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
