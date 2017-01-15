//
//  Skill.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

public enum SkillLevel : Int {
    case noSkill
    case beginner
    case confirmed
    case expert
}

open class Skill: Object {
    dynamic var domain: Domain? = nil
    dynamic var level: Int = 0
    dynamic var id: Int = 0
    dynamic var interested: Bool = false
    dynamic var name: String = ""
    dynamic var numAllies: Int = 0
    
    var skillLevel: SkillLevel {
        return self.level == 0 ? SkillLevel.noSkill
        : self.level == 1 ? SkillLevel.beginner
        : self.level == 2 ? SkillLevel.confirmed
        : self.level == 3 ? SkillLevel.expert
        : SkillLevel.noSkill
    }
}
