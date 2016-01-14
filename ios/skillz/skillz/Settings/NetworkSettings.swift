//
//  NetworkSettings.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit

enum Endpoints : String {
    case Users = "users/", Skills = "skills/"
}

class NetworkSettings: NSObject {
    static func root() -> String {
        return "http://52.28.188.147:8080/"
    }
}