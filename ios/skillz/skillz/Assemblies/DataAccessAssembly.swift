//
//  DataAccessAssembly.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import Typhoon

public class DataAccessAssembly: TyphoonAssembly {
    
    public var rootAssembly: RootAssembly!
    
    public dynamic func signInDataAccess() -> AnyObject {
        return TyphoonDefinition.withClass(SignInDataAccess.self) {
            (definition) in
            
            definition.injectProperty("session", with: self.rootAssembly.session())
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func usersDataAccess() -> AnyObject {
        return TyphoonDefinition.withClass(UsersDataAccess.self) {
            (definition) in
            
            definition.injectProperty("session", with: self.rootAssembly.session())
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func skillsDataAccess() -> AnyObject {
        return TyphoonDefinition.withClass(SkillsDataAccess.self) {
            (definition) in
            
            definition.injectProperty("session", with: self.rootAssembly.session())
            definition.scope = TyphoonScope.Singleton
        }
    }
}
