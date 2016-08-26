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
    case Leisure = 12
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
            case DomainIDMapping.Agile.rawValue:
                return UIImage(named: "DomainPictoAgile")
                
            case DomainIDMapping.Craft.rawValue:
                return UIImage(named: "DomainPictoCraft")
                
            case DomainIDMapping.Mobile.rawValue:
                return UIImage(named: "DomainPictoMobile")
                
            case DomainIDMapping.Back.rawValue:
                return UIImage(named: "DomainPictoBack")
                
            case DomainIDMapping.Cloud.rawValue:
                return UIImage(named: "DomainPictoCloud")
                
            case DomainIDMapping.Devops.rawValue:
                return UIImage(named: "DomainPictoDevOps")
                
            case DomainIDMapping.Data.rawValue:
                return UIImage(named: "DomainPictoData")
                
            case DomainIDMapping.Leisure.rawValue:
                return UIImage(named: "DomainPictoLeisure")
                
            case DomainIDMapping.Front.rawValue:
                return UIImage(named: "DomainPictoFront")
                
            default:
                return UIImage(named: "DomainPictoDefault")
            }
        }
    }
    
    var isFoundation: Bool {
        get {
            return self.id == DomainIDMapping.Agile.rawValue ||
                self.id == DomainIDMapping.Craft.rawValue ||
                self.id == DomainIDMapping.Mobile.rawValue ||
                self.id == DomainIDMapping.Back.rawValue ||
                self.id == DomainIDMapping.Cloud.rawValue ||
                self.id == DomainIDMapping.Devops.rawValue ||
                self.id == DomainIDMapping.Data.rawValue ||
                self.id == DomainIDMapping.Front.rawValue
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