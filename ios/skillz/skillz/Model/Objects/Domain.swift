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
    case agile = 1
    case craft = 2
    case mobile = 3
    case back = 4
    case cloud = 5
    case devops = 6
    case data = 7
    case leisure = 12
    case front = 8
}

open class Domain: Object {
    dynamic var color: String = ""
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var score: Int = 0
    
    let skills: List<Skill> = List<Skill>()
    
    var colorObject: UIColor! {
        get {
            return UIColor(self.color)
        }
    }
    
    var pictoImage: UIImage! {
        get {
            switch self.id {
            case DomainIDMapping.agile.rawValue:
                return UIImage(named: "DomainPictoAgile")
                
            case DomainIDMapping.craft.rawValue:
                return UIImage(named: "DomainPictoCraft")
                
            case DomainIDMapping.mobile.rawValue:
                return UIImage(named: "DomainPictoMobile")
                
            case DomainIDMapping.back.rawValue:
                return UIImage(named: "DomainPictoBack")
                
            case DomainIDMapping.cloud.rawValue:
                return UIImage(named: "DomainPictoCloud")
                
            case DomainIDMapping.devops.rawValue:
                return UIImage(named: "DomainPictoDevOps")
                
            case DomainIDMapping.data.rawValue:
                return UIImage(named: "DomainPictoData")
                
            case DomainIDMapping.leisure.rawValue:
                return UIImage(named: "DomainPictoLeisure")
                
            case DomainIDMapping.front.rawValue:
                return UIImage(named: "DomainPictoFront")
                
            default:
                return UIImage(named: "DomainPictoDefault")
            }
        }
    }
    
    var isFoundation: Bool {
        get {
            return self.id == DomainIDMapping.agile.rawValue ||
                self.id == DomainIDMapping.craft.rawValue ||
                self.id == DomainIDMapping.mobile.rawValue ||
                self.id == DomainIDMapping.back.rawValue ||
                self.id == DomainIDMapping.cloud.rawValue ||
                self.id == DomainIDMapping.devops.rawValue ||
                self.id == DomainIDMapping.data.rawValue ||
                self.id == DomainIDMapping.front.rawValue
        }
    }
    
    open func skillsOfLevel(_ level: SkillLevel) -> [Skill] {
        var skills = [Skill]()
        for skill in self.skills {
            if skill.skillLevel == level {
                skills.append(skill)
            }
        }
        return skills
    }
}
