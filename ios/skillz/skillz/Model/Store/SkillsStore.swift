//
//  SkillsStore.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit
import SwiftTask

open class SkillsStore: NSObject {
    static let sharedInstance = SkillsStore()
    
    var skills: [Skill]? = nil
    var getSkillsFromSearchTask: SkillsTask? = nil
    
    open var skillsDataAccess: SkillsDataAccess = SkillsDataAccess.sharedInstance

    open func getAllSkills() -> SkillsTask {
        return self.skillsDataAccess.getAllSkills()
            .success { [weak self] (skills: [Skill]) -> SkillsTask in
                self?.skills = skills
                return SkillsTask { fullfill, reject in
                    fullfill(skills)
                }
        }
    }
    
    open func getSkillsFromSearch(_ searchString: String) -> SkillsTask {
        let task: SkillsTask
        if (self.skills != nil) {
            task = SkillsTask { fullfill, reject in
                fullfill(self.skills!)
            }
        }
        else {
            task = self.getAllSkills()
        }
        
        self.getSkillsFromSearchTask?.cancel()
        self.getSkillsFromSearchTask = task
        var results = [Skill]()
        return task
            .success { (skills: [Skill]) -> SkillsTask in
                for skill: Skill in skills {
                    if skill.name.lowercased().folding(options: String.CompareOptions.diacriticInsensitive, locale: nil).contains(searchString.lowercased().folding(options: String.CompareOptions.diacriticInsensitive, locale: nil)) {
                        results.append(skill)
                    }
                }
                return SkillsTask { fullfill, reject in
                    fullfill(results)
                }
        }
    }
    
    open func getAllUsersForSkill(_ skill: Skill) -> UsersTask {
        return self.skillsDataAccess.getAllUsersForSkill(skill)
    }
}
