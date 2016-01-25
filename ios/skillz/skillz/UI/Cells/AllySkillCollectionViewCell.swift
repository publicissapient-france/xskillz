//
//  AllySkillCollectionViewCell.swift
//  skillz
//
//  Created by Florent Capon on 18/01/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllySkillCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarLoadingView: UIActivityIndicatorView!
    @IBOutlet weak var avatarMaskImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var lifeView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    
    var user: User? {
        didSet {
            self.nameLabel.text = self.user?.name
            self.companyLabel.text = self.user?.companyName
            self.xpLabel.text = String((self.user?.experienceCounter)!)
            self.avatarImageView.af_setImageWithURL(NSURL(string: (self.user?.gravatarUrl)!)!)
        }
    }
    var favorite: Bool! {
        didSet {
            self.lifeView.hidden = !self.favorite
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
        self.favorite = false
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 50.0
    }
}
