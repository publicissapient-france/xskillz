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
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var skillsCollectionView: UICollectionView!
    @IBOutlet weak var skillsSearchListCollectionView: UICollectionView!
    @IBOutlet weak var skillsSearchListWrapperView: UIView!
    
    var skillsStore: SkillsStore!
    var skills:[Skill]?
    var searchString:String?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.placeholder = i18n("search_skill.textfield.placeholder")
    }
    
    
    // MARK: - Search algo
    func updateSearch(search: String) {
        self.searchString = search
        self.skillsStore.getSkillsFromSearch(search)
            .success { [weak self] (skills:[Skill]) -> Void in
                self?.skills = skills
                self?.skillsSearchListCollectionView.reloadData()
//                self?.skillsCollectionView.reloadData()
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
            return 1
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
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let skill: Skill = self.skillFromIndexPath(indexPath)!
        //        if (collectionView == self.skillsSearchListCollectionView) {
        let skillCell: SkillSearchListCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SkillSearchListCell", forIndexPath: indexPath) as! SkillSearchListCollectionViewCell
        skillCell.skill(skill, searchString: self.searchString!, numberOfUsers: 4)
        
        return skillCell
        //        }
        //        else {
        //            let skillCell: SkillCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SkillCell", forIndexPath: indexPath) as! SkillCollectionViewCell
        //
        //            return skillCell
        //        }
        
    }
    
    func skillFromIndexPath(indexPath: NSIndexPath) -> Skill? {
        if (self.skills != nil) {
            return self.skills![indexPath.row]
        }
        return nil
    }
    
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            if (collectionView == self.skillsSearchListCollectionView) {
                return CGSizeMake(self.skillsSearchListCollectionView.bounds.size.width, SkillSearchListCollectionViewCell.cellDefaultHeight())
            }
            else {
                return CGSizeMake(self.skillsCollectionView.bounds.size.width, AllyCollectionViewCell.cellDefaultHeight())
            }
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
