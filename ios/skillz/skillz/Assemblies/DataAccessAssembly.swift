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
    
    public dynamic func usersDataAccess() -> AnyObject {
        return TyphoonDefinition.withClass(UsersDataAccess.self) {
            (definition) in
            
            definition.scope = TyphoonScope.Singleton
        }
    }
}
