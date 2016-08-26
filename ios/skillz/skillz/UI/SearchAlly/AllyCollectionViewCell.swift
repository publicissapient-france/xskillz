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
    @IBOutlet weak var avatarRingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var top1DomainLabel: UILabel!
    @IBOutlet weak var top1DomainView: UIView!
    @IBOutlet weak var top1DomainImageView: UIView!
    @IBOutlet weak var top2DomainLabel: UILabel!
    @IBOutlet weak var top2DomainView: UIView!
    @IBOutlet weak var top2DomainImageView: UIView!
    @IBOutlet weak var top3DomainLabel: UILabel!
    @IBOutlet weak var top3DomainView: UIView!
    @IBOutlet weak var top3DomainImageView: UIView!
    @IBOutlet weak var topDomainsView: UIView!
    @IBOutlet weak var xpLabel: UILabel!
    
    var user: User? {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.8
            paragraphStyle.headIndent = 5.0
            let attributedString = NSMutableAttributedString(string: self.user!.name.uppercaseString)
            attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            self.nameLabel.attributedText = attributedString
            self.xpLabel.text = String(self.user!.experienceCounter)
            self.avatarImageView.af_setImageWithURL(NSURL(string: self.user!.gravatarUrl)!)
            
            let topDomains = self.user!.foundationDomains(true)
//            if (topDomains.count > 0) {
//                Colors.colorizeImageView(self.avatarRingImageView, color: topDomains[0].colorObject)
//            }
            
            var topDomainView: UIView
            var topDomainImageView: UIImageView
            var topDomainLabel: UILabel
            for i in 0 ..< 3 {
                topDomainView = self.valueForKey("top\(i + 1)DomainView") as! UIView
                topDomainImageView = self.valueForKey("top\(i + 1)DomainImageView") as! UIImageView
                topDomainLabel = self.valueForKey("top\(i + 1)DomainLabel") as! UILabel
                if (topDomains.count < (i + 1)) {
                    topDomainView.hidden = true
                }
                else {
                    let domain: Domain = topDomains[i]
                    Colors.colorizeImageView(topDomainImageView, color: domain.colorObject)
                    topDomainView.hidden = false
                    topDomainLabel.attributedText = self.formatDomainName(domain.name, domainRank: (i + 1), color: domain.colorObject)
                }
            }
        }
    }
    
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10.0
        
        var attrString = NSMutableAttributedString(string: "Swift Answer")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        

        self.avatarImageView.layer.mask = self.avatarMaskImageView.layer
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarImageView.af_cancelImageRequest()
        self.avatarImageView.image = nil
        self.avatarLoadingView.hidden = false
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 140.0
    }
    
    // MARK: - Private
    private func formatDomainName(name: NSString, domainRank: NSInteger, color: UIColor) -> NSAttributedString {
        let formattedString: NSMutableAttributedString = NSMutableAttributedString()
        formattedString.appendAttributedString(NSAttributedString(string: name.substringToIndex(1).uppercaseString, attributes: self.domainFirstLetterAttribute(domainRank, color: color)))
        formattedString.appendAttributedString(NSAttributedString(string: name.substringFromIndex(1).uppercaseString, attributes: self.domainDefaultAttribute(domainRank)))
        return formattedString
    }
    
    private func domainFirstLetterAttribute(domainRank: NSInteger, color: UIColor) -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Bold, size: (13.0 - CGFloat(domainRank - 1) * 2.0))
        ]
    }
    
    private func domainDefaultAttribute(domainRank: NSInteger) -> [String : AnyObject] {
        return [
            NSForegroundColorAttributeName: Colors.greyColor(),
            NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: (13.0 - CGFloat(domainRank - 1) * 2.0))
        ]
    }
}
