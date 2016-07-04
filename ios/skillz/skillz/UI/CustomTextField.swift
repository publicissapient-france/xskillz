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
        self.tintColor = Colors.mainColor()
    }
}
