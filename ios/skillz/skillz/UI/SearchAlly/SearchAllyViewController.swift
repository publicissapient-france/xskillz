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
    var usersStore: UsersStore = UsersStore.sharedInstance
    var users: [User]?
    var searchString: String?
    var searchTimer: Timer?
    var swipeTutoHidden: Bool! {
        didSet {
            self.swipeTutoView.isHidden = self.swipeTutoHidden
        }
    }
    var onSkillSelect: SkillSelectType?
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.font = Fonts.screenTitleFont()
        self.titleLabel.text = i18n("search_ally.title").uppercased()
        self.searchTextField.placeholder = i18n("search_ally.textfield.placeholder")
        self.swipeLabel.text = i18n("search_ally.swipe")
    }
    
    
    // MARK: - Search & results
    fileprivate func updateSearch(_ search: String, delay: TimeInterval = 0.0) {
        if (delay > 0.0) {
            self.searchTimer?.invalidate()
            self.searchTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(SearchAllyViewController.updateSearchTimer(_:)), userInfo: search, repeats: false)
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
    
    fileprivate func clearResults() -> Void {
        self.users = nil
        self.alliesCollectionView.reloadData()
        self.swipeTutoView.isHidden = true
    }
    
    func updateSearchTimer(_ timer: Timer) {
        self.updateSearch(timer.userInfo as! String)
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
        self.updateSearch(newString as String, delay:0.7)
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
        if (self.users != nil) {
            if ((self.swipeTutoHidden) != nil) {
                self.swipeTutoView.isHidden = true
            }
            else {
                self.swipeTutoView.isHidden = (users!.count > 0)
            }
            return self.users!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AllyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllyCell", for: indexPath) as! AllyCollectionViewCell
        let user: User = self.userFromIndexPath(indexPath)!
        cell.user = user
        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.alliesCollectionView.bounds.size.width, height: AllyCollectionViewCell.cellDefaultHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectAlly(self.userFromIndexPath(indexPath)!)
    }
    
    
    // MARK: - Helpers
    fileprivate func userFromIndexPath(_ indexPath: IndexPath) -> User? {
        if (self.users != nil) {
            return self.users![indexPath.row]
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
                if self?.onSkillSelect != nil {
                    self?.onSkillSelect!(skill!)
                }
            }
            break
            
        default:
            break
        }
    }
}

extension SearchAllyViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
