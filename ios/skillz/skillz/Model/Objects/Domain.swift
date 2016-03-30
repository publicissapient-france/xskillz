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
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var score: Int = 0
    
    let skills: List<Skill> = List<Skill>()
    
    public func color() -> UIColor {
        switch self.id {
        case DomainIDMapping.Agile.rawValue:
            return UIColor(rgba: "#d7d5d0")
            
        case DomainIDMapping.Craft.rawValue:
            return UIColor(rgba: "#afcd37")
            
        case DomainIDMapping.Mobile.rawValue:
            return UIColor(rgba: "#6186eb")
            
        case DomainIDMapping.Back.rawValue:
            return UIColor(rgba: "#e23d27")
            
        case DomainIDMapping.Cloud.rawValue:
            return UIColor(rgba: "#06a99c")
            
        case DomainIDMapping.Devops.rawValue:
            return UIColor(rgba: "#f99b1d")
            
        case DomainIDMapping.Data.rawValue:
            return UIColor(rgba: "#df0075")
            
        case DomainIDMapping.Loisirs.rawValue:
            return UIColor(rgba: "#000000")
            
        case DomainIDMapping.Front.rawValue:
            return UIColor(rgba: "#00a0d4")
            
        default:
            return UIColor.blackColor()
        }
    }
}
