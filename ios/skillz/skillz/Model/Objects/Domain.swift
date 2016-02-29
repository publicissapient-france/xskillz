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
    dynamic var score: Int = 0
    
    let skills: List<Skill> = List<Skill>()
    
    public func color() -> UIColor {
        switch self.id {
        case DomainIDMapping.Agile.rawValue:
            return UIColor(rgba: "#93a6ad")
            
        case DomainIDMapping.Craft.rawValue:
            return UIColor(rgba: "#b9dd80")
            
        case DomainIDMapping.Mobile.rawValue:
            return UIColor(rgba: "#62949b")
            
        case DomainIDMapping.Back.rawValue:
            return UIColor(rgba: "#d14939")
            
        case DomainIDMapping.Cloud.rawValue:
            return UIColor(rgba: "#555e96")
            
        case DomainIDMapping.Devops.rawValue:
            return UIColor(rgba: "#fed453")
            
        case DomainIDMapping.Data.rawValue:
            return UIColor(rgba: "#f6638f")
            
        case DomainIDMapping.Loisirs.rawValue:
            return UIColor(rgba: "#000000")
            
        case DomainIDMapping.Front.rawValue:
            return UIColor(rgba: "#fd9632")
            
        default:
            return UIColor.blackColor()
        }
    }
}
