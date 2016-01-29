//
//  AllyDomainCollectionReusableView.swift
//  skillz
//
//  Created by Florent Capon on 27/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyDomainCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var backgroundLineImageView: UIImageView!
    @IBOutlet weak var backgroundMiddleImageView: UIImageView!
    
    var domain: Domain! {
        didSet {
            self.domainLabel.text = self.domain.name.uppercaseString
            self.backgroundLineImageView.image = self.backgroundLineImageView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.backgroundLineImageView.tintColor = self.domain.color()
            self.backgroundMiddleImageView.image = self.backgroundMiddleImageView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.backgroundMiddleImageView.tintColor = self.domain.color()
            self.backgroundColorView.backgroundColor = self.domain.color()
        }
    }
}
