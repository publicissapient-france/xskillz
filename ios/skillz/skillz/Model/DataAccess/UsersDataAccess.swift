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

public typealias FullUsersTask = Task<ProgressMultiTasks, [User], NSError>
public typealias UserAvatarTask = Task<ProgressTask, UIImage, NSError>
public typealias UsersTask = Task<ProgressTask, [User], NSError>
public typealias UserTask = Task<ProgressTask, User, NSError>

open class UsersDataAccess: AbstractDataAccess {
    static let sharedInstance = UsersDataAccess()
    
    init() {
        super.init(root: NetworkSettings.root())
    }
    
    open func getAllUsers() -> UsersTask {
        AbstractDataAccess.activityIndicatorInStatusBarVisible(true)
        let task = UsersTask { [weak self] progress, fulfill, reject, configure in
            self?.GET(Endpoints.Users.rawValue).responseJSON { response in
                    if let JSON: NSArray = response.result.value as? NSArray {
                        let realm = try! RealmStore.defaultStore()
                        try! realm.write({ () -> Void in
                            var users = [User]()
                            for userDictionary in JSON {
                                let user = try! realm.create(User.self, value: userDictionary)
                                users.append(user)
                            }
                            AbstractDataAccess.activityIndicatorInStatusBarVisible(false)
                            fulfill(users)
                        })
                    }
            }
        }
        
        return task
    }
    
    open func getFullUser(_ user: User) -> UserTask {
        AbstractDataAccess.activityIndicatorInStatusBarVisible(true)
        let task = UserTask { [weak self] progress, fulfill, reject, configure in
            self?.GET(NetworkSettings.user(user)).responseJSON { response in
                    if let JSON: NSDictionary = response.result.value as? NSDictionary {
                        let realm = try! RealmStore.defaultStore()
                        try! realm.write({ () -> Void in
                            let user = try! realm.create(User.self, value: JSON)
                            AbstractDataAccess.activityIndicatorInStatusBarVisible(false)
                            fulfill(user)
                        })
                    }
            }
        }
        
        return task
    }
}
