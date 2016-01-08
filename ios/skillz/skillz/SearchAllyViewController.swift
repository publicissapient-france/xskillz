//
//  SearchAllyViewController.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask

class SearchAllyViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var alliesCollectionView: UICollectionView!
    
    var usersStore: UsersStore!
    var users:[User]?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.placeholder = i18n("search_ally.textfield.placeholder")
        self.usersStore.getAllUsers()
    }
    
    
    // MARK: - Search algo
    func updateSearch(search: String) {
        self.usersStore.getUsersFromSearch(search)
            .success { [weak self] (users:[User]) -> Void in
                self?.users = users
                self?.alliesCollectionView.reloadData()
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newString:NSString = self.searchString() as NSString
        newString = newString.stringByReplacingCharactersInRange(range, withString: string)
        self.updateSearch(newString as String)
        return true
    }
    
    
    // MARK: - Helpers
    func searchString() -> String {
        return self.searchTextField.text!
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.users != nil) {
            return self.users!.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: AllyCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("AllyCell", forIndexPath: indexPath) as! AllyCollectionViewCell
        let user: User = self.userFromIndexPath(indexPath)!
        cell.user = user
        
        return cell
    }
    
    func userFromIndexPath(indexPath: NSIndexPath) -> User? {
        if (self.users != nil) {
            return self.users![indexPath.row]
        }
        return nil
    }
    
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSizeMake(self.alliesCollectionView.bounds.size.width, AllyCollectionViewCell.cellDefaultHeight())
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
