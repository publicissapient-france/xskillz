//
//  UserView.swift
//  XSkillz
//
//  Created by Florent Capon on 11/08/2016.
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class UserView: UIView {
    @IBOutlet weak var button: UIButton!
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
    
    
    // MARK: - Init
    class func loadFromNib() -> UserView {
        return UINib(nibName: "UserView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UserView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.mask = self.userMaskImageView.layer
    }
    
    
    // MARK: - Avatar
    func loadAvatar() {
        self.userImageView.af_setImageWithURL(NSURL(string: (self.user.gravatarUrl))!)
    }
    
    
    // MARK: - Size
    func sizeFitting() -> CGSize {
        return UserView.size(self.user)
    }
    
    class func size(user: User) -> CGSize {
        let userNameLabelWidth: CGFloat = (user.name as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, 0.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: Fonts.mainFont(FontsStyle.Regular, size: 13.0)], context: nil).width
        return CGSizeMake((userNameLabelWidth + 33.0 + 1.0), self.defaultHeight())
    }
    
    class func defaultHeight() -> CGFloat {
        return 25.0
    }
}