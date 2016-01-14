//
//  Skill.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

public class Skill: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var domain: Domain? = nil
}
