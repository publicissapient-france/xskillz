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
    case office = 1
//    case ????? = 2
    case craft = 3
    case agile = 4
    case data = 5
    case devops = 6
    case cloud = 7
    case front = 8
    case back = 9
    case mobile = 10
    case iot = 11
    case leisure = 12
    case languages = 13
}

open class Domain: Object {
    dynamic var color: String?
    let id = RealmOptional<Int>() // because backend can return null value (!)
    dynamic var name: String? = nil
    dynamic var score: Int = 0
    
    let skills: List<Skill> = List<Skill>()
    
    var colorObject: UIColor! {
        get {
            if self.color != nil {
                return UIColor(self.color!)
            }
            return UIColor.black
        }
    }
    
    var pictoImage: UIImage! {
        get {
            guard let id = self.id.value else { return UIImage(named: "DomainPictoDefault") }
            switch id {
            case DomainIDMapping.office.rawValue:
                return UIImage(named: "DomainPictoOffice")
                
            case DomainIDMapping.craft.rawValue:
                return UIImage(named: "DomainPictoCraft")
                
            case DomainIDMapping.agile.rawValue:
                return UIImage(named: "DomainPictoAgile")
                
            case DomainIDMapping.data.rawValue:
                return UIImage(named: "DomainPictoData")
                
            case DomainIDMapping.devops.rawValue:
                return UIImage(named: "DomainPictoDevOps")
                
            case DomainIDMapping.cloud.rawValue:
                return UIImage(named: "DomainPictoCloud")
                
            case DomainIDMapping.front.rawValue:
                return UIImage(named: "DomainPictoFront")
                
            case DomainIDMapping.back.rawValue:
                return UIImage(named: "DomainPictoBack")
                
            case DomainIDMapping.mobile.rawValue:
                return UIImage(named: "DomainPictoMobile")
                
            case DomainIDMapping.iot.rawValue:
                return UIImage(named: "DomainPictoIOT")
                
            case DomainIDMapping.leisure.rawValue:
                return UIImage(named: "DomainPictoLeisure")
                
            case DomainIDMapping.languages.rawValue:
                return UIImage(named: "DomainPictoLanguages")
                
            default:
                return UIImage(named: "DomainPictoDefault")
            }
        }
    }
    
    var isFoundation: Bool {
        get {
            guard let id = self.id.value else { return false }
            return id == DomainIDMapping.agile.rawValue ||
                id == DomainIDMapping.craft.rawValue ||
                id == DomainIDMapping.mobile.rawValue ||
                id == DomainIDMapping.back.rawValue ||
                id == DomainIDMapping.cloud.rawValue ||
                id == DomainIDMapping.devops.rawValue ||
                id == DomainIDMapping.data.rawValue ||
                id == DomainIDMapping.front.rawValue
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
