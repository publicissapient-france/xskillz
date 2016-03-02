//
//  HomeViewController.swift
//  skillz
//
//  Created by Florent Capon on 10/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import DeviceKit

class HomeViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    @IBOutlet weak var backgroundImagaView: UIImageView!
    @IBOutlet weak var googleConnectButton: UIButton!

    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Device() == .iPhone6) {
            self.backgroundImagaView.image = UIImage(named: "BackgroundSkillz~iphone6")
        }
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
//        self.googleConnectButton.setTitle(i18n("welcome").uppercaseString, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Sign in results
    func signInSucceed(idToken: NSString!, name: NSString!, email: NSString!) {
        DLog("token:\(idToken) ; name:\(name) ; email:\(email)")
        
        self.performSegueWithIdentifier("showHome", sender: nil)
    }
    
    func signInFailed(error: NSError!) {
        DLog("error:\(error)")
    }
    
    
    // MARK: - GIDSignInDelegate
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let name = user.profile.name
                let email = user.profile.email
                
                self.signInSucceed(idToken, name: name, email: email)
            }
            else {
                self.signInFailed(error)
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
    }
    
    
    // MARK: - Actions
    @IBAction func signInAction(sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}