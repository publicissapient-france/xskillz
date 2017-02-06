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

open class UsersStore: NSObject {
    static let sharedInstance = UsersStore()
    
    var users: [User]? = nil
    var getUsersFromSearchTask: UsersTask? = nil
    
    open var usersDataAccess: UsersDataAccess = UsersDataAccess.sharedInstance
    
    open func getAllUsers() -> UsersTask {
        return self.usersDataAccess.getAllUsers()
            .success { [weak self] (users: [User]) -> UsersTask in
                self?.users = users
                return UsersTask { fullfill, reject in
                    fullfill(users)
                }
        }
    }
    
    open func getUsersFromSearch(_ searchString: String) -> UsersTask {
        let task: UsersTask
        if (self.users != nil) {
            task = UsersTask { fullfill, reject in
                fullfill(self.users!)
            }
        }
        else {
            task = self.getAllUsers()
        }
        
        self.getUsersFromSearchTask?.cancel()
        self.getUsersFromSearchTask = task
        var results = [User]()
        return self.getUsersFromSearchTask!
            .success { (users: [User]) -> UsersTask in
                for user: User in users {
                    if user.name.lowercased().folding(options: String.CompareOptions.diacriticInsensitive, locale: nil).contains(searchString.lowercased().folding(options: String.CompareOptions.diacriticInsensitive, locale: nil)) {
                        results.append(user)
                    }
                }
                return UsersTask { fullfill, reject in
                    fullfill(results)
                }
        }
    }
    
    open func getFullUser(_ user: User) -> UserTask {
        return self.usersDataAccess.getFullUser(user)
    }
    
    open func getFullUsers(_ users: [User]) -> FullUsersTask {
        var tasks = [UserTask]()
        for user: User in users {
            tasks.append(self.getFullUser(user))
        }
        
        return Task.some(tasks)
    }
}
