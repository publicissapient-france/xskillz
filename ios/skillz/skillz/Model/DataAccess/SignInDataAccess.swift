//
//  SignInDataAccess.swift
//  skillz
//
//  Created by Florent Capon on 29/03/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask

enum SignInError : Int {
    case Unknown
    case Unauthorized
}

public typealias SignInTask = Task<ProgressTask, SignIn, NSError>

public class SignInDataAccess: AbstractDataAccess, GIDSignInDelegate {
    
    var delegate:SignInDelegate?
    var silently:Bool = false
    var signInAfterDisconnecting:Bool = false
    
    
    // MARK: - Init
    init() {
        super.init(root: NetworkSettings.root())
    }
    
    
    // MARK: - Public API
    public func signIn(selectAccount: Bool = false) {
        DLog()
        self.silently = false
        if (selectAccount) {
            self.signInAfterDisconnecting = true
            GIDSignIn.sharedInstance().disconnect()
        }
        self.googleSignIn()
    }
    
    public func signInSilently() {
        DLog()
        self.silently = true
        self.googleSignIn(true)
    }
    
    public func hasAlreadyAuth() -> Bool {
        return GIDSignIn.sharedInstance().hasAuthInKeychain()
    }
    
    
    // MARK: - Private API
    public func skillzSignIn(email: String) -> SignInTask {
        DLog()
        let task = SignInTask { [weak self] progress, fulfill, reject, configure in
            self?.POST(Endpoints.SignIn.rawValue, parameters: ["email": email]).validate()
                .responseJSON { response in
                    AbstractDataAccess.activityIndicatorInStatusBarVisible(false)
                    if let JSON: NSDictionary = response.result.value as? NSDictionary {
                        let realm = try! RealmStore.defaultStore()
                        try! realm.write({ () -> Void in
                            let signIn = try! realm.create(SignIn.self, value: JSON)
                            AbstractDataAccess.activityIndicatorInStatusBarVisible(false)
                            self!.session.skillzToken = signIn.token
                            fulfill(signIn)
                        })
                    }
                    else {
                        let error: NSError = NSError(domain: "", code: SignInError.Unauthorized.rawValue, userInfo: nil)
                        reject(error)
                    }
            }
        }
        
        return task
    }
    
    func googleSignIn(silently: Bool = false) {
        DLog()
        AbstractDataAccess.activityIndicatorInStatusBarVisible(true)
        GIDSignIn.sharedInstance().delegate = self
        if (silently) {
            GIDSignIn.sharedInstance().signInSilently()
        }
        else {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    // MARK: - Sign in results
    func signInSucceed(idToken: NSString!, name: NSString!, email: NSString!) {
        DLog("token:\(idToken) ; name:\(name) ; email:\(email)")
        
        self.session.googleToken = idToken
        self.session.googleName = name
        self.session.googleEMail = email
        
        self.skillzSignIn(String(email))
            .success { [weak self] (signIn:SignIn) -> Void in
                if ((self!.delegate) != nil) {
                    self!.delegate!.signInSucceed(String(email), silently: self!.silently)
                }
            }.failure { [weak self] (error:NSError?, isCancelled: Bool) -> Void in
                if ((self!.delegate) != nil) {
                    self!.delegate!.signInFailed(String(email), error: error!, silently: self!.silently)
                }
        }
    }
    
    func signInFailed(error: NSError!) {
        DLog("error:\(error)")
        if ((self.delegate) != nil) {
            self.delegate!.signInFailed(nil, error: error, silently: self.silently)
        }
    }
    
    
    // MARK: - GIDSignInDelegate
    public func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            //                let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            
            self.signInSucceed(idToken, name: name, email: email)
        }
        else {
            self.signInFailed(error)
        }
    }
    
    public func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!, withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        if (self.signInAfterDisconnecting) {
            self.signInAfterDisconnecting = false
            self.signIn()
        }
    }
}
