//
//  User.swift
//  skillz
//
//  Created by Florent Capon on 22/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

open class User: Object {
    dynamic var companyName: String = ""
    dynamic var experienceCounter: Int = 0
    dynamic var gravatarUrl: String = ""
    dynamic var id: Int = 0
    dynamic var name: String = ""
    
    let domains: List<Domain> = List<Domain>()
    
    var avatarURL: String {
        get {
            if !gravatarUrl.contains("http:") {
                return "http:" + gravatarUrl
            }
            return gravatarUrl
        }
    }
    
    open func foundationDomains(_ orderedByScore: Bool = true) -> [Domain] {
        var domains = [Domain]()
        for domain in self.domains {
            if domain.isFoundation {
                domains.append(domain)
            }
        }
        
        if orderedByScore {
            domains = domains.sorted(by: {$0.score > $1.score})
        }
        
        return domains
    }
    
    open func noFoundationDomains(_ orderedByScore: Bool = true) -> [Domain] {
        var domains = [Domain]()
        for domain in self.domains {
            if !domain.isFoundation {
                domains.append(domain)
            }
        }
        
        if orderedByScore {
            domains = domains.sorted(by: {$0.score > $1.score})
        }
        
        return domains
    }
    
    open func findSkill(_ wantedSkill: Skill?) -> Skill? {
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
    
    open func isInterestedBySkill(_ skill: Skill?) -> Bool {
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
