//
//  AllyDomainCollectionReusableView.swift
//  skillz
//
//  Created by Florent Capon on 27/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyDomainCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var domainFirstLetterLabel: UILabel!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var pictoImageView: UIImageView!
    @IBOutlet weak var resultsNumberLabel: UILabel!
    
    var domain: Domain? {
        didSet {
            if (self.domain != nil) {
                let index = self.domain!.name.startIndex.advancedBy(1)
                self.domainFirstLetterLabel.text = self.domain!.name.substringToIndex(index).uppercaseString
                self.domainFirstLetterLabel.textColor = self.domain!.colorObject
                self.domainLabel.text = self.domain!.name.substringFromIndex(index).uppercaseString
                self.lineView.backgroundColor = self.domain!.colorObject
                self.pictoImageView.image = self.domain!.pictoImage
                Colors.colorizeImageView(self.pictoImageView, color: self.domain!.colorObject)
            }
            else {
                // TODO: default domain
            }
        }
    }
    var numberOfResultsText: String? {
        didSet {
            self.resultsNumberLabel.text = self.numberOfResultsText
        }
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 33.0
    }
}