//
//  Fonts.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

enum FontsStyle : Int {
    case Regular
    case Bold
    case SemiBold
}

class Fonts: NSObject {
    
    static func mainFont(style:FontsStyle = FontsStyle.Regular, size: CGFloat = 12.0) -> UIFont {
        var fontName: String
        
        switch style {
        case FontsStyle.Bold:
            fontName = "SanFranciscoDisplay-Bold"
            
        case FontsStyle.SemiBold:
            fontName = "SanFranciscoDisplay-SemiBold";
            
        default:
            fontName = "SanFranciscoDisplay-Regular"
        }
        
        return UIFont(name: fontName, size: size)!
    }
    
}
