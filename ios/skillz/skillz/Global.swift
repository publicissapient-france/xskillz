//
//  Global.swift
//  skillz
//
//  Created by Florent Capon on 22/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import Foundation

func i18n(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func i18n(_ key: String, defaultValue: String) -> String {
    return NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: defaultValue, comment: "")
}

func DLog(_ message: String = "", function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        print(">>>", dateFormatter.string(from: Date()), "|", file.components(separatedBy: "/").last!, function, "#", line, ":", message)
    #else
    #endif
}
