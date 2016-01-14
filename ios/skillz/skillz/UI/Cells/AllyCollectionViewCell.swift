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
    @IBOutlet weak var lifeAndStarsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    
    var user:User? {
        didSet {
            self.nameLabel.text = self.user?.name
            self.companyLabel.text = self.user?.companyName
            self.xpLabel.text = String((self.user?.experienceCounter)!)
            UsersDataAccess.getUserAvatarImage(self.user)
                .success { [weak self] (image: UIImage) -> Void in
                    self?.avatarImage = image
            }
        }
    }
    var avatarImage:UIImage? {
        didSet {
            self.avatarImageView.image = self.avatarImage
            self.avatarLoadingView.hidden = true
        }
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 134.0
    }
    
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
}
