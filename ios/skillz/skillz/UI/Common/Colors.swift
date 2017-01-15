//
//  Colors.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class Colors: NSObject {
    
    static func mainColor() -> UIColor {
        return UIColor("#7a3a76")
    }
    
    static func greyColor() -> UIColor {
        return UIColor("#6e6e6e")
    }
    
    
    static func colorizeImageView(_ imageView: UIImageView!, color: UIColor!) {
        let image: UIImage = imageView.image!
        imageView.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = color
    }
}
