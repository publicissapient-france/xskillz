//
//  Domain.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

enum DomainIDMapping: Int {
    case Agile = 1
    case Craft = 2
    case Mobile = 3
    case Back = 4
    case Cloud = 5
    case Devops = 6
    case Data = 7
    case Loisirs = 12
    case Front = 8
}

public class Domain: Object {
    dynamic var color: String = ""
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var score: Int = 0
    
    let skills: List<Skill> = List<Skill>()
    
    var colorObject: UIColor! {
        get {
            return UIColor(rgba: self.color)
        }
    }
    
    var pictoImage: UIImage! {
        get {
            switch self.id {
            case DomainIDMapping.Mobile.rawValue:
                return UIImage(named: "DomainPictoMobile")
                
            default:
                return UIImage(named: "DomainPictoMobile")
            }
        }
    }
    
    public func skillsOfLevel(level: SkillLevel) -> [Skill] {
        var skills = [Skill]()
        for skill in self.skills {
            if skill.skillLevel == level {
                skills.append(skill)
            }
        }
        return skills
    }
}