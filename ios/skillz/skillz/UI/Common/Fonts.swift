//
//  Fonts.swift
//  skillz
//
//  Created by Florent Capon on 12/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

enum FontsStyle : Int {
    case Bold
    case Light
    case Regular
    case SemiBold
}

class Fonts: NSObject {
    
    static func logAllFonts() {
        for family in UIFont.familyNames() {
            print("\(family)")
            
            for name in UIFont.fontNamesForFamilyName(family) {
                print("   \(name)")
            }
        }
    }
    
    static func mainFont(style:FontsStyle = FontsStyle.Regular, size: CGFloat = 12.0) -> UIFont! {
        return self.fontComfortaa(style, size: size)
    }
    
    static func screenTitleFont(size: CGFloat = 12.0) -> UIFont! {
        var fontName: String
        
        fontName = "SanFranciscoDisplay-Medium"
        
        return UIFont(name: fontName, size: size)
    }
    
    static func xpFont(size: CGFloat = 12.0) -> UIFont! {
        return self.fontSteelworksVintage(FontsStyle.Regular)
    }
    
    
    static func fontComfortaa(style:FontsStyle = FontsStyle.Regular, size: CGFloat = 12.0) -> UIFont! {
        var fontName: String
        
        switch style {
        case FontsStyle.Bold:
            fontName = "Comfortaa-Bold"
            
        case FontsStyle.Light:
            fontName = "Comfortaa-Light";
            
        default:
            fontName = "Comfortaa"
        }
        
        return UIFont(name: fontName, size: size)
    }
    
    static func fontSteelworksVintage(style:FontsStyle = FontsStyle.Regular, size: CGFloat = 12.0) -> UIFont! {
        var fontName: String
        
        fontName = "SteelworksVintageDemo"
        
        return UIFont(name: fontName, size: size)
    }
}