//
//  Session.swift
//  skillz
//
//  Created by Florent Capon on 17/03/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

open class Session: Object {
    static let sharedInstance = Session()
    
    dynamic var googleEMail: NSString?
    dynamic var googleName: NSString?
    dynamic var googleToken: NSString?
    dynamic var skillzToken: NSString?
}
