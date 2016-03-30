//
//  SignIn.swift
//  skillz
//
//  Created by Florent Capon on 30/03/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

public class SignIn: Object {
    dynamic var email: String = ""
    dynamic var token: String = ""
}
