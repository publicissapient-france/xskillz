//
//  HomeViewController.swift
//  skillz
//
//  Created by Florent Capon on 10/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import DeviceKit

enum SignInErrorAlert : Int {
    case TryAnotherAccount = 1
}

class HomeViewController: UIViewController, GIDSignInUIDelegate, SignInDelegate, UIAlertViewDelegate {
    @IBOutlet weak var backgroundImagaView: UIImageView!
    @IBOutlet weak var googleConnectButton: UIButton!

    var signInStore: SignInStore!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Device() == .iPhone6) {
            self.backgroundImagaView.image = UIImage(named: "BackgroundSkillz~iphone6")
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        self.signInStore.setDelegate(self)
        if (self.signInStore.hasAlreadyAuth()) {
            self.googleConnectButton.userInteractionEnabled = false
            self.signInStore.signInSilently()
        }
        else {
            self.googleConnectButton.userInteractionEnabled = true
        }
        self.googleConnectButton.setTitle(i18n("welcome").uppercaseString, forState: UIControlState.Normal)
    }
    
    
    // MARK: - SignInDelegate
    func signInSucceed(email: String, silently: Bool) {
        self.performSegueWithIdentifier("ShowHome", sender: nil)
    }
    
    func signInFailed(email: String?, error: NSError, silently: Bool) {
        if (email != nil) {
            let alert: UIAlertView = UIAlertView()
            alert.title = i18n("signin.error.unauthorized.alert.title")
            alert.message = String(format: i18n("signin.error.unauthorized.alert.message"), email!)
            alert.addButtonWithTitle(i18n("action.ok"))
            alert.addButtonWithTitle(i18n("signin.error.unauthorized.alert.action.try_another_account"))
            alert.delegate = self
            alert.show()
        }
    }
    
    
    // MARK: - UIAlertViewDelegate
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if (buttonIndex == SignInErrorAlert.TryAnotherAccount.rawValue) {
            self.signInStore.signIn(true)
        }
    }
    
    
    // MARK: - Actions
    @IBAction func signInAction(sender: UIButton) {
        self.signInStore.signIn()
    }
}