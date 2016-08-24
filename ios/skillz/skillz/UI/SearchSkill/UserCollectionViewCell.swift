//
//  UserCollectionViewCell.swift
//  XSkillz
//
//  Created by Florent Capon on 24/08/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userMaskImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var color: UIColor! {
        didSet {
            Colors.colorizeImageView(self.likeImageView, color: color)
        }
    }
    var like: Bool = false {
        didSet {
            self.likeImageView.hidden = !self.like
        }
    }
    var user: User! {
        didSet {
            self.userNameLabel.text = self.user.name
        }
    }
    
    // MARK: - Size
    class func cellSize(user: User) -> CGSize {
        let labelWidth: CGFloat = (user.name as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, 0.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: 13.0)], context: nil).width
        
        return CGSizeMake(labelWidth, self.cellDefaultHeight())
    }
    
    class func cellDefaultHeight() -> CGFloat {
        return 40.0
    }
    
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.mask = self.userMaskImageView.layer
    }
    
    
    // MARK: - Avatar
    func loadAvatar() {
        self.userImageView.af_setImageWithURL(NSURL(string: (self.user.gravatarUrl))!)
    }
}