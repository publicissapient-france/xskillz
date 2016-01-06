//
//  NetworkSettings.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit

class NetworkSettings: NSObject {
    static func root() -> String {
        return "http://52.28.188.147:8080/"
    }
    
    static func endpoints() -> Endoints {
        return Endoints()
    }
}

class Endoints: NSObject {
    static func users() -> String {
        return "users/"
    }
}