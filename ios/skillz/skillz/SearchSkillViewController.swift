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
    @IBOutlet weak var skillsResultsListCollectionView: UICollectionView!
    @IBOutlet weak var skillsResultsListWrapperView: UIView!
    @IBOutlet weak var skillsResultsNumberOfAlliesLabel: UILabel!
    @IBOutlet weak var skillsSearchListCollectionView: UICollectionView!
    @IBOutlet weak var skillsSearchListCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skillsSearchListWrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
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
    var searchString:String?
    var selectedSkill:Skill?
    var skillsStore: SkillsStore!
    var skills:[Skill]?
    var users:[[User]]?
    var usersStore: UsersStore!
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = i18n("search_skill.title").uppercaseString
        self.searchTextField.placeholder = i18n("search_skill.textfield.placeholder")
    }
    
    
    // MARK: - Search
    private func updateSearch(search: String) {
        self.loadingVisible = true
        self.users = nil
        self.skillsResultsListCollectionView.reloadData()
        self.updateNumberOfAllies(0)
        self.searchString = search
        self.skillsStore.getSkillsFromSearch(search)
            .success { [weak self] (skills:[Skill]) -> Void in
                self?.loadingVisible = false
                self?.skills = skills
                self?.skillsSearchListCollectionView.reloadData()
                NSTimer.scheduledTimerWithTimeInterval(0.05, target: self!, selector: Selector("resizeSearchListCollection"), userInfo: nil, repeats: false)
                
        }
    }
    
    func resizeSearchListCollection() -> Void {
        self.skillsSearchListCollectionViewHeightConstraint.constant = min((self.skillsSearchListCollectionView.contentSize.height), 210.0)
    }
    
    
    // MARK: - Results
    private func selectSkill(skill: Skill) -> Void {
        self.loadingVisible = true
        self.selectedSkill = skill
        self.searchTextField.text = skill.name
        self.searchTextField.resignFirstResponder()
        self.skillsSearchListWrapperView.hidden = true
        self.skillsStore.getAllUsersForSkill(skill)
            .success { [weak self] (users:[User]) -> FullUsersTask in
                self?.updateNumberOfAllies(users.count)
                return (self?.usersStore.getFullUsers(users))!
            }
            .success { [weak self] (users:[User]) -> Void in
                self?.orderUsers(users)
                self?.skillsResultsListCollectionView.reloadData()
                self?.loadingVisible = false
        }
    }
    
    private func orderUsers(users: [User]) -> Void {
        var noSkillUsers = [User]()
        var beginnerUsers = [User]()
        var confirmedUsers = [User]()
        var expertUsers = [User]()
        for user: User in users {
            for domain:Domain in user.domains {
                for skill:Skill in domain.skills {
                    if (skill.id == self.selectedSkill!.id) {
                        switch skill.skillLevel {
                        case SkillLevel.NoSkill:
                            noSkillUsers.append(user)
                            break
                            
                        case SkillLevel.Beginner:
                            beginnerUsers.append(user)
                            break
                            
                        case SkillLevel.Confirmed:
                            confirmedUsers.append(user)
                            break
                            
                        case SkillLevel.Expert:
                            expertUsers.append(user)
                            break
                        }
                    }
                }
            }
        }
        self.users = [noSkillUsers, beginnerUsers, confirmedUsers, expertUsers]
    }
    
    private func updateNumberOfAllies(number: Int) -> Void {
        let stringFormat = i18n(number > 1 ? "search_skill.number_of_allies.plural" : "search_skill.number_of_allies.singular")
        self.skillsResultsNumberOfAlliesLabel.text = String(format: stringFormat, number)
        self.skillsResultsNumberOfAlliesLabel.hidden = (number == 0)
    }
    
    
    // MARK: - Navigation
    private func selectAlly(ally: User) -> Void {
        self.performSegueWithIdentifier("ShowAlly", sender: ally)
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "ShowAlly":
            let viewController = segue.destinationViewController as! AllyViewController
            viewController.ally = sender as! User
            break
            
        default:
            break
        }
    }
    
    
    // MARK: - Delegates
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newString:NSString = textField.text! as NSString
        newString = newString.stringByReplacingCharactersInRange(range, withString: string)
        self.updateSearch(newString as String)
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        self.updateSearch("")
        return true
    }
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if (collectionView == self.skillsSearchListCollectionView) {
            return 1
        }
        else {
            return self.numberOfSkillsLevels()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.skillsSearchListCollectionView) {
            self.skillsSearchListWrapperView.hidden = true
            if (self.searchString == nil || self.searchString!.characters.count < 2) {
                return 0
            }
            if (self.skills != nil) {
                self.skillsSearchListWrapperView.hidden = (self.skills?.count == 0)
                return self.skills!.count
            }
            return 0
        }
        else {
            if (self.users != nil) {
                return (self.usersForSkillAtSection(section)!.count)
            }
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (collectionView == self.skillsSearchListCollectionView) {
            let skill: Skill = self.skillFromIndexPath(indexPath)!
            let skillCell: SkillSearchListCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SkillSearchListCell", forIndexPath: indexPath) as! SkillSearchListCollectionViewCell
            skillCell.skill(skill, searchString: self.searchString!, numberOfUsers: 4)
            
            return skillCell
        }
        else {
            let user: User = self.userFromIndexPath(indexPath)!
            let allyCell: AllySkillCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("AllyCell", forIndexPath: indexPath) as! AllySkillCollectionViewCell
            allyCell.user = user
            allyCell.favorite = self.isUserHasSkillSelectedAsFavorite(user)
            
            return allyCell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let skill: Skill = self.skillFromIndexPath(indexPath)!
            let view: SkillStarsCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "SkillStarsReusableView", forIndexPath: indexPath) as! SkillStarsCollectionReusableView
            view.level = self.skillLevelFromSection(indexPath.section)
            return view
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView == self.skillsSearchListCollectionView) {
            self.selectSkill(self.skillFromIndexPath(indexPath)!)
        }
        else {
            self.selectAlly(self.userFromIndexPath(indexPath)!)
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            if (collectionView == self.skillsSearchListCollectionView) {
                return CGSizeMake(self.skillsSearchListCollectionView.bounds.size.width, SkillSearchListCollectionViewCell.cellDefaultHeight())
            }
            else {
                return CGSizeMake((self.skillsResultsListCollectionView.bounds.size.width / 2.0), AllySkillCollectionViewCell.cellDefaultHeight())
            }
    }
    
    
    // MARK: - Helpers
    private func numberOfSkillsLevels() -> Int {
        if self.users == nil {
            return 0
        }
        var value = 0
        for skillUsers:[User] in self.users! {
            if skillUsers.count > 0 {
                value++
            }
        }
        return value
    }
    
    private func userFromIndexPath(indexPath: NSIndexPath) -> User? {
        return self.usersForSkillAtSection(indexPath.section)![indexPath.row]
    }
    
    private func skillFromIndexPath(indexPath: NSIndexPath) -> Skill? {
        if (self.skills != nil) {
            return self.skills![indexPath.row]
        }
        return nil
    }
    
    private func skillLevelFromSection(section: Int) -> SkillLevel! {
        var skillLevelIndex = SkillLevel.NoSkill.rawValue
        var index = (self.numberOfSectionsInCollectionView(self.skillsResultsListCollectionView) - 1)
        for var i = 0; i < self.users?.count; i++ {
            if (self.users![i].count == 0) {
                skillLevelIndex++
                continue
            }
            if (index == section) {
                return SkillLevel(rawValue: skillLevelIndex)
            }
            skillLevelIndex++
            index--
        }
        return SkillLevel.NoSkill
    }
    
    private func usersForSkillAtSection(section: Int) -> [User]? {
        var index = -1
        for skillUsers:[User] in self.users!.reverse() {
            if skillUsers.count > 0 {
                index++
            }
            if index == section {
                return skillUsers
            }
        }
        return nil
    }
    
    private func isUserHasSkillSelectedAsFavorite(user: User) -> Bool {
        for domain:Domain in user.domains {
            for skill:Skill in domain.skills {
                if (skill.id == self.selectedSkill!.id) {
                    return skill.interested
                }
            }
        }
        return false
    }
}
