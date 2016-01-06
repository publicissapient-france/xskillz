//
//  SearchAllyViewController.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask

class SearchAllyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var alliesCollectionView: UICollectionView!
    
    var usersStore: UsersStore!

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.placeholder = i18n("search_ally.textfield.placeholder")
        self.usersStore.getAllUsers()
    }
    
    
    // MARK: - Search algo
    func updateSearch(search: String) {
        DLog(search)
        self.usersStore.getUsersFromSearch(search)
            .success { (users:[User]) -> Void in
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
