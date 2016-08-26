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
    
    public func foundationDomains(orderedByScore: Bool = true) -> [Domain] {
        var domains = [Domain]()
        for domain in self.domains {
            if domain.isFoundation {
                domains.append(domain)
            }
        }
        
        if orderedByScore {
            domains = domains.sort({$0.score > $1.score})
        }
        
        return domains
    }
    
    public func noFoundationDomains(orderedByScore: Bool = true) -> [Domain] {
        var domains = [Domain]()
        for domain in self.domains {
            if !domain.isFoundation {
                domains.append(domain)
            }
        }
        
        if orderedByScore {
            domains = domains.sort({$0.score > $1.score})
        }
        
        return domains
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