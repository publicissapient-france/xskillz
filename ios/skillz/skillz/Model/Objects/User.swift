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
}