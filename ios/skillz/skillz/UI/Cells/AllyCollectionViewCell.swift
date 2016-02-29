//
//  AllyCollectionViewCell.swift
//  skillz
//
//  Created by Florent Capon on 06/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarLoadingView: UIActivityIndicatorView!
    @IBOutlet weak var avatarMaskImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var top1DomainLabel: UILabel!
    @IBOutlet weak var top1DomainView: UIView!
    @IBOutlet weak var top2DomainLabel: UILabel!
    @IBOutlet weak var top2DomainView: UIView!
    @IBOutlet weak var top3DomainLabel: UILabel!
    @IBOutlet weak var top3DomainView: UIView!
    @IBOutlet weak var topDomainsView: UIView!
    @IBOutlet weak var xpLabel: UILabel!
    
    var user: User? {
        didSet {
            self.nameLabel.text = self.user?.name
            self.companyLabel.text = self.user?.companyName
            self.xpLabel.text = String((self.user?.experienceCounter)!)
            self.avatarImageView.af_setImageWithURL(NSURL(string: (self.user?.gravatarUrl)!)!)
            
            let topDomains: [Domain] = (self.user?.techDomainsSortedByScore())!
            
            var topDomainView: UIView
            var topDomainLabel: UILabel
            for var i = 0; i < 3; i++ {
                topDomainView = self.valueForKey("top\(i + 1)DomainView") as! UIView
                topDomainLabel = self.valueForKey("top\(i + 1)DomainLabel") as! UILabel
                if (topDomains.count < (i + 1)) {
                    topDomainView.hidden = true
                }
                else {
                    topDomainView.hidden = false
                    topDomainLabel.attributedText = self.formatDomainName(topDomains[i].name)
                }
            }
        }
    }
    
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarImageView.layer.mask = self.avatarMaskImageView.layer
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarImageView.af_cancelImageRequest()
        self.avatarImageView.image = nil
        self.avatarLoadingView.hidden = false
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 143.0
    }
    
    // MARK: - Private
    private func formatDomainName(name: NSString) -> NSAttributedString {
        let formattedString: NSMutableAttributedString = NSMutableAttributedString()
        formattedString.appendAttributedString(NSAttributedString(string: name.substringToIndex(1).uppercaseString, attributes: self.domainFirstLetterAttribute()))
        formattedString.appendAttributedString(NSAttributedString(string: name.substringFromIndex(1).uppercaseString, attributes: self.domainDefaultAttribute()))
        return formattedString
    }
    
    private func domainFirstLetterAttribute() -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: Colors.mainColor(),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.SemiBold, size: 14.0)
        ]
    }
    
    private func domainDefaultAttribute() -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: Colors.greyColor(),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: 14.0)
        ]
    }
}
