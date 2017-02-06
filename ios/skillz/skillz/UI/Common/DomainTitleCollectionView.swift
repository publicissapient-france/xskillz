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
            if let name = self.domain?.name {
                let index = name.characters.index(name.startIndex, offsetBy: 1)
                self.domainFirstLetterLabel.text = name.substring(to: index).uppercased()
                self.domainFirstLetterLabel.textColor = self.domain!.colorObject
                self.domainLabel.text = name.substring(from: index).uppercased()
                self.lineView.backgroundColor = self.domain!.colorObject
                self.pictoImageView.image = self.domain!.pictoImage
                Colors.colorizeImageView(self.pictoImageView, color: self.domain!.colorObject)
            }
            else {
                // TODO: default domain
                let unranked = i18n("skill.unranked")
                let index = unranked.characters.index(unranked.startIndex, offsetBy: 1)
                self.domainFirstLetterLabel.text = unranked.substring(to: index).uppercased()
                self.domainFirstLetterLabel.textColor = UIColor.black
                self.domainLabel.text = unranked.substring(from: index).uppercased()
                self.lineView.backgroundColor = UIColor.black
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
