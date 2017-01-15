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
    let level = RealmOptional<Int>() // because backend can return null value (!)
    dynamic var id: Int = 0
    dynamic var interested: Bool = false
    dynamic var name: String = ""
    dynamic var numAllies: Int = 0
    
    var skillLevel: SkillLevel {
        guard let level = self.level.value else { return .noSkill }
        return level == 0 ? .noSkill
        : level == 1 ? .beginner
        : level == 2 ? .confirmed
        : level == 3 ? .expert
        : .noSkill
    }
}
