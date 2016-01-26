//
//  AllyViewController.swift
//  skillz
//
//  Created by Florent Capon on 26/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarLoadingView: UIActivityIndicatorView!
    @IBOutlet weak var avatarMaskImageView: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var xpView: UIView!
    
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

    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    @IBAction func actionClose() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
