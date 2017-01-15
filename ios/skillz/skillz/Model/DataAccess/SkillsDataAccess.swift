//
//  SkillsDataAccess.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Alamofire
import UIKit
import RealmSwift
import SwiftTask

public typealias SkillsTask = Task<ProgressTask, [Skill], NSError>
public typealias SkillTask = Task<ProgressTask, Skill, NSError>

open class SkillsDataAccess: AbstractDataAccess {
    static let sharedInstance = SkillsDataAccess()
    
    init() {
        super.init(root: NetworkSettings.root())
    }
    
    open func getAllSkills() -> SkillsTask {
        AbstractDataAccess.activityIndicatorInStatusBarVisible(true)
        
        let task = SkillsTask { [weak self] progress, fulfill, reject, configure in
            self?.GET(Endpoints.Skills.rawValue).responseJSON { response in
                if let JSON: NSArray = response.result.value as? NSArray {
                    let realm = try! RealmStore.defaultStore()
                    try! realm.write({ () -> Void in
                        var skills = [Skill]()
                        for skillDictionary in JSON {
                            let skill = try! realm.create(Skill.self, value: skillDictionary)
                            skills.append(skill)
                        }
                        AbstractDataAccess.activityIndicatorInStatusBarVisible(false)
                        fulfill(skills)
                    })
                }
            }
        }
        
        return task
    }
    
    open func getAllUsersForSkill(_ skill: Skill) -> UsersTask {
        AbstractDataAccess.activityIndicatorInStatusBarVisible(true)
        let task = UsersTask { [weak self] progress, fulfill, reject, configure in
            self?.GET(NetworkSettings.usersForSkill(skill)).responseJSON { response in
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
}
