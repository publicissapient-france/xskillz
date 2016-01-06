//
//  UsersDataAccess.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftTask

public typealias UsersTask = Task<ProgressTask, [User], NSError>

public class UsersDataAccess: AbstractDataAccess {
    init() {
        super.init(root: NetworkSettings.root())
    }
    
    public func getAllUsers() -> UsersTask {
        let task = UsersTask { progress, fulfill, reject, configure in
            self.GET("users/")
                .responseJSON { response in
                    if let JSON: NSMutableArray = response.result.value as? NSMutableArray {
                        let realm = try! RealmStore.inMemoryStore()
                        try! realm.write({ () -> Void in
                            var users = [User]()
                            for userDictionary in JSON {
                                let user = try! realm.create(User.self, value: userDictionary)
                                users.append(user)
                            }
                            fulfill(users)
                        })
                    }
            }
        }
        
        return task
    }
}
