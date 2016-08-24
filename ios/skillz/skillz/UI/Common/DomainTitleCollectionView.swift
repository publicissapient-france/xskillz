//
//  DomainTitleCollectionView.swift
//  XSkillz
//
//  Created by Florent Capon on 11/08/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class DomainTitleCollectionView: UITableViewHeaderFooterView {
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
                self.domainFirstLetterLabel.text = "N"
                self.domainFirstLetterLabel.textColor = UIColor.blackColor()
                self.domainLabel.text = "on classé".uppercaseString
                self.lineView.backgroundColor = UIColor.blackColor()
                self.pictoImageView.image = nil
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
    
    class func defaultHeight() -> CGFloat {
        return 33.0
    }
    
    class func defaultHeightWithSpacing() -> CGFloat {
        return self.defaultHeight() + 20.0
    }
}
