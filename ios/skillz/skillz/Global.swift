//
//  Global.swift
//  skillz
//
//  Created by Florent Capon on 22/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import Foundation

func i18n(key:String) -> String {
    return NSLocalizedString(key, comment: "")
}

func DLog(message: AnyObject = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
    print(file.componentsSeparatedByString("/").last, function, " #", line, ":", message)
}
