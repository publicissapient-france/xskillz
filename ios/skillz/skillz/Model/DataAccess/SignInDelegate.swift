//
//  SignInDelegate.swift
//  skillz
//
//  Created by Florent Capon on 30/03/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation

public protocol SignInDelegate {
    func signInSucceed(email: String, silently: Bool)
    func signInFailed(email: String?, error: NSError, silently: Bool)
}