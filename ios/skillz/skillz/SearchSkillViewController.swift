//
//  SearchSkillViewController.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask

class SearchSkillViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var skillsResultsListCollectionView: UICollectionView!
    @IBOutlet weak var skillsResultsListWrapperView: UIView!
    @IBOutlet weak var skillsResultsNumberOfAlliesLabel: UILabel!
    @IBOutlet weak var skillsSearchListCollectionView: UICollectionView!
    @IBOutlet weak var skillsSearchListCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skillsSearchListWrapperView: UIView!
    
    var searchString:String?
    var selectedSkill:Skill?
    var skillsStore: SkillsStore!
    var skills:[Skill]?
    var users:[[User]]?
    var usersStore: UsersStore!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = -4.0
        paragraphStyle.alignment = NSTextAlignment.Center
        self.titleLabel.attributedText = NSAttributedString(string: i18n("search_skill.title").uppercaseString, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
        self.searchTextField.placeholder = i18n("search_skill.textfield.placeholder")
    }
    
    
    // MARK: - Search algo
    func updateSearch(search: String) {
        self.searchString = search
        self.skillsStore.getSkillsFromSearch(search)
            .success { [weak self] (skills:[Skill]) -> Void in
                self?.skills = skills
                //                self?.skillsSearchListCollectionView.performBatchUpdates({ () -> Void in
                //                    self?.skillsSearchListCollectionView.reloadData()
                //                    },
                //                    completion: { (complete) -> Void in
                //                        self?.skillsSearchListCollectionViewHeightConstraint.constant = min((self?.skillsSearchListCollectionView.contentSize.height)!, 210.0)
                //                })
                self?.skillsSearchListCollectionView.reloadData()
        }
    }
    
    
    // MARK: - UITextFieldDelegate
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
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if (collectionView == self.skillsSearchListCollectionView) {
            return 1
        }
        else {
            return self.numberOfSkillsLevels()
        }
    }
    
    func numberOfSkillsLevels() -> Int {
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
    
    func usersForSkillAtSection(section: Int) -> [User]? {
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
            allyCell.favorite = self.isFavorite(user)
            
            return allyCell
        }
    }
    
    func isFavorite(user: User) -> Bool {
        for domain:Domain in user.domains {
            for skill:Skill in domain.skills {
                if (skill.id == self.selectedSkill!.id) {
                    return skill.interested
                }
            }
        }
        return false
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let view: SkillStarsCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "SkillStarsReusableView", forIndexPath: indexPath) as! SkillStarsCollectionReusableView
            let sectionToLevel = abs(indexPath.section - 3)
            view.level = sectionToLevel == 0 ? SkillLevel.NoSkill
                : sectionToLevel == 1 ? SkillLevel.Beginner
                : sectionToLevel == 2 ? SkillLevel.Confirmed
                : sectionToLevel == 3 ? SkillLevel.Expert
                : SkillLevel.NoSkill
            return view
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func skillFromIndexPath(indexPath: NSIndexPath) -> Skill? {
        if (self.skills != nil) {
            return self.skills![indexPath.row]
        }
        return nil
    }
    
    func userFromIndexPath(indexPath: NSIndexPath) -> User? {
        return self.usersForSkillAtSection(indexPath.section)![indexPath.row]
    }
    
    
    // MARK: - UICollectionViewDelegate
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectSkill(self.skillFromIndexPath(indexPath)!)
    }
    
    
    // MARK: - Fetch users and skills details
    func selectSkill(skill: Skill) -> Void {
        self.selectedSkill = skill
        self.searchTextField.text = skill.name
        self.searchTextField.resignFirstResponder()
        self.skillsSearchListWrapperView.hidden = true
        self.skillsStore.getAllUsersForSkill(skill)
            .success { [weak self] (users:[User]) -> FullUsersTask in
                let stringFormat = i18n(users.count > 1 ? "search_skill.number_of_allies.plural" : "search_skill.number_of_allies.singular")
                self?.skillsResultsNumberOfAlliesLabel.text = String(format: stringFormat, users.count)
                self?.skillsResultsNumberOfAlliesLabel.hidden = false
                return (self?.usersStore.getFullUsers(users))!
            }
            .success { [weak self] (users:[User]) -> Void in
                self?.sortUsers(users)
                self?.skillsResultsListCollectionView.reloadData()
        }
    }
    
    func sortUsers(users: [User]) -> Void {
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
