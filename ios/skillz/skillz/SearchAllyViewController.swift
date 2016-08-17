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
    
    @IBOutlet weak var alliesCollectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var swipeTutoView: UIView!
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
    var usersStore: UsersStore!
    var users: [User]?
    var searchString: String?
    var searchTimer: NSTimer?
    var swipeTutoHidden: Bool! {
        didSet {
            self.swipeTutoView.hidden = self.swipeTutoHidden
        }
    }
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.font = Fonts.screenTitleFont()
        self.titleLabel.text = i18n("search_ally.title").uppercaseString
        self.searchTextField.placeholder = i18n("search_ally.textfield.placeholder")
        self.swipeLabel.text = i18n("search_ally.swipe")
    }
    
    
    // MARK: - Search & results
    private func updateSearch(search: String, delay: NSTimeInterval = 0.0) {
        if (delay > 0.0) {
            self.searchTimer?.invalidate()
            self.searchTimer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(SearchAllyViewController.updateSearchTimer(_:)), userInfo: search, repeats: false)
            return
        }
        self.clearResults()
        self.loadingVisible = true
        self.searchString = search
        self.usersStore.getUsersFromSearch(search)
            .success { [weak self] (users:[User]) -> Void in
                self?.users = users
                self?.alliesCollectionView.reloadData()
                self?.loadingVisible = false
        }
    }
    
    private func clearResults() -> Void {
        self.users = nil
        self.alliesCollectionView.reloadData()
        self.swipeTutoView.hidden = true
    }
    
    func updateSearchTimer(timer: NSTimer) {
        self.updateSearch(timer.userInfo as! String)
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
        self.updateSearch(newString as String, delay:0.7)
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        self.updateSearch("")
        return true
    }
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.users != nil) {
            if ((self.swipeTutoHidden) != nil) {
                self.swipeTutoView.hidden = true
            }
            else {
                self.swipeTutoView.hidden = (users!.count > 0)
            }
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
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSizeMake(self.alliesCollectionView.bounds.size.width, AllyCollectionViewCell.cellDefaultHeight())
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectAlly(self.userFromIndexPath(indexPath)!)
    }
    
    
    // MARK: - Helpers
    private func userFromIndexPath(indexPath: NSIndexPath) -> User? {
        if (self.users != nil) {
            return self.users![indexPath.row]
        }
        return nil
    }
}
