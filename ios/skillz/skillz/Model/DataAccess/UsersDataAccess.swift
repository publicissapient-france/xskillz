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

public class UsersDataAccess: AbstractDataAccess {
    init() {
        super.init(root: NetworkSettings.root())
    }
    
    public func getAllUsers() -> UsersTask {
        let task = UsersTask { [weak self] progress, fulfill, reject, configure in
            self?.GET(Endpoints.Users.rawValue).validate()
                .responseJSON { response in
                    if let JSON: NSArray = response.result.value as? NSArray {
                        let realm = try! RealmStore.defaultStore()
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
    
    public func getFullUser(user: User) -> UserTask {
        let task = UserTask { [weak self] progress, fulfill, reject, configure in
            self?.GET(NetworkSettings.user(user)).validate()
                .responseJSON { response in
                    if let JSON: NSDictionary = response.result.value as? NSDictionary {
                        let realm = try! RealmStore.defaultStore()
                        try! realm.write({ () -> Void in
                            let user = try! realm.create(User.self, value: JSON)
                            fulfill(user)
                        })
                    }
            }
        }
        
        return task
    }
    
    class func getUserAvatarImage(user: User!) -> UserAvatarTask {
        let task = UserAvatarTask { fullfill, reject in
            AbstractDataAccess.GET(user.gravatarUrl).validate().responseImage { response in
                if let image = response.result.value {
                    fullfill(image)
                }
            }
        }
        
        return task
    }
}
