//
//  NetworkSettings.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit

enum Endpoints : String {
    case Users = "api/mobile/users/", Skills = "api/mobile/skills/"
}

class NetworkSettings: NSObject {
    static func root() -> String {
        return "http://skillz.xebia.fr/"
    }
    
    static func usersForSkill(_ skill: Skill) -> String {
        let endpoint = Endpoints.Skills.rawValue
        return "\(endpoint)\(skill.id)/users"
    }
    
    static func user(_ user: User) -> String {
        let endpoint = Endpoints.Users.rawValue
        return "\(endpoint)\(user.id)"
    }
}
