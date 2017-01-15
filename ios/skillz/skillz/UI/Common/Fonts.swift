//
//  Fonts.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

enum FontsStyle : Int {
    case bold
    case light
    case regular
    case semiBold
}

class Fonts: NSObject {
    
    static func logAllFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    static func mainFont(_ style:FontsStyle = FontsStyle.regular, size: CGFloat = 12.0) -> UIFont! {
        return self.fontComfortaa(style, size: size)
    }
    
    static func screenTitleFont(_ size: CGFloat = 12.0) -> UIFont! {
        var fontName: String
        
        fontName = "SanFranciscoDisplay-Medium"
        
        return UIFont(name: fontName, size: size)
    }
    
    static func xpFont(_ size: CGFloat = 12.0) -> UIFont! {
        return self.fontSteelworksVintage(FontsStyle.regular)
    }
    
    
    static func fontComfortaa(_ style:FontsStyle = FontsStyle.regular, size: CGFloat = 12.0) -> UIFont! {
        var fontName: String
        
        switch style {
        case FontsStyle.bold:
            fontName = "Comfortaa-Bold"
            
        case FontsStyle.light:
            fontName = "Comfortaa-Light";
            
        default:
            fontName = "Comfortaa"
        }
        
        return UIFont(name: fontName, size: size)
    }
    
    static func fontSteelworksVintage(_ style:FontsStyle = FontsStyle.regular, size: CGFloat = 12.0) -> UIFont! {
        var fontName: String
        
        fontName = "SteelworksVintageDemo"
        
        return UIFont(name: fontName, size: size)
    }
}
