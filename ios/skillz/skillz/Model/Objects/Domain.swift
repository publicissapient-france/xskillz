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
    case Front = 15
}

public class Domain: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    
    let skills: List<Skill> = List<Skill>()
    
    public func color() -> UIColor {
        switch self.id {
        case DomainIDMapping.Agile.rawValue:
            return UIColor(rgba: "#f3f3f1")
            
        case DomainIDMapping.Craft.rawValue:
            return UIColor(rgba: "#e7f0c3")
            
        case DomainIDMapping.Mobile.rawValue:
            return UIColor(rgba: "#b9c8f2")
            
        case DomainIDMapping.Back.rawValue:
            return UIColor(rgba: "#e6beb9")
            
        case DomainIDMapping.Cloud.rawValue:
            return UIColor(rgba: "#6e6e6e")//
            
        case DomainIDMapping.Devops.rawValue:
            return UIColor(rgba: "#6e6e6e")//
            
        case DomainIDMapping.Data.rawValue:
            return UIColor(rgba: "#f6b3d6")
            
        case DomainIDMapping.Loisirs.rawValue:
            return UIColor(rgba: "#d1d1d1")
            
        case DomainIDMapping.Front.rawValue:
            return UIColor(rgba: "#b3e3f2")
            
        default:
            return UIColor.blackColor()
        }
    }
}
