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
            self.likeImageView.isHidden = !self.like
        }
    }
    var user: User! {
        didSet {
            self.userNameLabel.text = self.user.name
        }
    }
    
    // MARK: - Size
    class func cellSize(_ user: User) -> CGSize {
        let labelWidth: CGFloat = (user.name as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.regular, size: 13.0)], context: nil).width
        
        return CGSize(width: (38.0 + labelWidth + 5.0), height: self.cellDefaultHeight())
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
        self.userImageView.af_setImage(withURL: URL(string: (self.user.gravatarUrl))!)
    }
}
