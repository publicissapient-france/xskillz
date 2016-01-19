//
//  Skill.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

enum SkillLevel : Int {
    case NoSkill
    case Beginner
    case Confirmed
    case Expert
}

public class Skill: Object {
    dynamic var domain: Domain? = nil
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var interested: Bool = false
    dynamic var level: Int = 0
    
    var skillLevel: SkillLevel {
        return self.level == 0 ? SkillLevel.NoSkill
        : self.level == 1 ? SkillLevel.Beginner
        : self.level == 2 ? SkillLevel.Confirmed
        : self.level == 3 ? SkillLevel.Expert
        : SkillLevel.NoSkill
    }
}
