//
//  User.swift
//  skillz
//
//  Created by Florent Capon on 22/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

public class User: Object {
    dynamic var companyName: String = ""
    dynamic var experienceCounter: Int = 0
    dynamic var gravatarUrl: String = ""
    dynamic var id: Int = 0
    dynamic var name: String = ""
    
    let domains: List<Domain> = List<Domain>()
    
    public func techDomainsSortedByScore() -> [Domain] {
        var sorted: [Domain] = self.domains.sort({$0.score > $1.score})
        for i in 0 ..< sorted.count {
            if sorted[i].id == DomainIDMapping.Loisirs.rawValue {
                sorted.removeAtIndex(i)
                break;
            }
        }
        return sorted
    }
    
    public func findSkill(wantedSkill: Skill?) -> Skill? {
        if wantedSkill == nil {
            return nil
        }
        for domain in self.domains {
            for skill in domain.skills {
                if skill.id == wantedSkill!.id {
                    return skill
                }
            }
        }
        return nil
    }
    
    public func isInterestedBySkill(skill: Skill?) -> Bool {
        if skill == nil {
            return false
        }
        let wantedSkill = self.findSkill(skill)
        if (wantedSkill != nil) {
            return wantedSkill!.interested
        }
        return false
    }
}