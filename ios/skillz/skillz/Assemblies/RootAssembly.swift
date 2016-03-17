//
//  RootAssembly.swift
//  skillz
//
//  Created by Florent Capon on 17/03/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import Typhoon

public class RootAssembly: TyphoonAssembly {
    
    public var storesAssembly: StoresAssembly!
    
    
    // MARK: - Session
    public dynamic func session() -> AnyObject {
        return TyphoonDefinition.withClass(Session.self) {
            (definition) in
            
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    
    // MARK: - Controllers
    public dynamic func homeViewController() -> AnyObject {
        return TyphoonDefinition.withClass(HomeViewController.self) {
            (definition) in
            
            definition.injectProperty("session", with: self.session())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
    
    public dynamic func searchSkillViewController() -> AnyObject {
        return TyphoonDefinition.withClass(SearchSkillViewController.self) {
            (definition) in
            
            definition.injectProperty("skillsStore", with: self.storesAssembly.skillsStore())
            definition.injectProperty("usersStore", with: self.storesAssembly.usersStore())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
    
    public dynamic func searchAllyViewController() -> AnyObject {
        return TyphoonDefinition.withClass(SearchAllyViewController.self) {
            (definition) in
            
            definition.injectProperty("usersStore", with: self.storesAssembly.usersStore())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
    
    public dynamic func allyViewController() -> AnyObject {
        return TyphoonDefinition.withClass(AllyViewController.self) {
            (definition) in
            
            definition.injectProperty("usersStore", with: self.storesAssembly.usersStore())
            definition.scope = TyphoonScope.ObjectGraph
        }
    }
}
