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
        for var i = 0; i < sorted.count; i++ {
            if sorted[i].id == DomainIDMapping.Loisirs.rawValue {
                sorted.removeAtIndex(i)
                break;
            }
        }
        return sorted
    }
}