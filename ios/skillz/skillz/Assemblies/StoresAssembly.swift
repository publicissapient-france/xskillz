//
//  StoresAssembly.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import Typhoon

public class StoresAssembly: TyphoonAssembly {
    
    public var dataAccessAssembly: DataAccessAssembly!
    
    public dynamic func searchSkillViewController() -> AnyObject {
        return TyphoonDefinition.withClass(SearchSkillViewController.self) {
            (definition) in
            
            definition.injectProperty("skillsStore", with: self.skillsStore())
            definition.injectProperty("usersStore", with: self.usersStore())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
    
    public dynamic func searchAllyViewController() -> AnyObject {
        return TyphoonDefinition.withClass(SearchAllyViewController.self) {
            (definition) in
            
            definition.injectProperty("usersStore", with: self.usersStore())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
    
    public dynamic func allyViewController() -> AnyObject {
        return TyphoonDefinition.withClass(AllyViewController.self) {
            (definition) in
            
            definition.injectProperty("usersStore", with: self.usersStore())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
    
    public dynamic func usersStore() -> AnyObject {
        return TyphoonDefinition.withClass(UsersStore.self) {
            (definition) in
            
            definition.injectProperty("usersDataAccess", with: self.dataAccessAssembly.usersDataAccess())
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func skillsStore() -> AnyObject {
        return TyphoonDefinition.withClass(SkillsStore.self) {
            (definition) in
            
            definition.injectProperty("skillsDataAccess", with: self.dataAccessAssembly.skillsDataAccess())
            definition.scope = TyphoonScope.Singleton
        }
    }
}
