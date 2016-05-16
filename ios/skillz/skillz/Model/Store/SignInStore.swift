//
//  SignInStore.swift
//  skillz
//
//  Created by Florent Capon on 29/03/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

public class SignInStore: NSObject {
    
    public var signInDataAccess: SignInDataAccess!
    
    public func setDelegate(delegate: SignInDelegate) -> Void {
        self.signInDataAccess.delegate = delegate
    }
    
    public func getDelegate() -> SignInDelegate {
        return self.signInDataAccess.delegate!
    }
    
    public func signIn(selectAccount: Bool = false) {
        DLog()
        return self.signInDataAccess.signIn(selectAccount)
    }
    
    public func signInSilently() {
        DLog()
        return self.signInDataAccess.signInSilently()
    }
    
    public func hasAlreadyAuth() -> Bool {
        return self.signInDataAccess.hasAlreadyAuth()
    }
}
