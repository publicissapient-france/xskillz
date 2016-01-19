//
//  UsersStore.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask
//AsyncSwift

public class UsersStore: NSObject {
    
    var users: [User]? = nil
    
    public var usersDataAccess: UsersDataAccess!
    
    public func getAllUsers() -> UsersTask {
        return self.usersDataAccess.getAllUsers()
            .success { [weak self] (users: [User]) -> UsersTask in
                self?.users = users
                return UsersTask { fullfill, reject in
                    fullfill(users)
                }
        }
    }
    
    public func getUsersFromSearch(searchString: String) -> UsersTask {
        let task: UsersTask
        if (self.users != nil) {
            task = UsersTask { fullfill, reject in
                fullfill(self.users!)
            }
        }
        else {
            task = self.getAllUsers()
        }
        
        var results = [User]()
        return task
            .success { (users: [User]) -> UsersTask in
                for user: User in users {
                    if user.name.lowercaseString.containsString(searchString.lowercaseString) {
                        results.append(user)
                    }
                }
                return UsersTask { fullfill, reject in
                    fullfill(results)
                }
        }
    }
    
    public func getFullUser(user: User) -> UserTask {
        return self.usersDataAccess.getFullUser(user)
    }
    
    public func getFullUsers(users: [User]) -> FullUsersTask {
        var tasks = [UserTask]()
        for user: User in users {
            tasks.append(self.getFullUser(user))
        }
        
        return Task.some(tasks)
    }
    
    class func getUserAvatarImage(user: User!) -> UserAvatarTask {
        return UsersDataAccess.getUserAvatarImage(user)
    }
}
