//
//  CustomTextField.swift
//  skillz
//
//  Created by Florent Capon on 11/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        self.layer.borderColor = Colors.mainColor().CGColor
        self.layer.borderWidth = 3.0
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.tintColor = Colors.mainColor()
    }
}
