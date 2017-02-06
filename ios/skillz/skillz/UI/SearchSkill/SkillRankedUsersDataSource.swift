//
//  SkillRankedUsersDataSource.swift
//  XSkillz
//
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class SkillRankedUsersDataSource: NSObject, UICollectionViewDataSource {
    var domain: Domain?
    var users: [User]!
    var avatarsCache: [String: UIImage]!
    
    // MARK: - Init
    init(domain: Domain?, users: [User]!) {
        self.domain = domain
        self.users = users
        self.avatarsCache = [String: UIImage]()
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let user = self.userFromIndexPath(indexPath)
        
        cell.user = user
        if self.domain != nil {
            cell.color = self.domain!.colorObject
        }
        loadAvatar(cell)
        
        return cell
    }
    
    func loadAvatar(_ forCell: UserCollectionViewCell) {
        let avatarURL = forCell.user.avatarURL
        if let cachedImage = avatarsCache[avatarURL] {
            forCell.userImageView.image = cachedImage
        }
        else {
            forCell.userImageView.af_setImage(
                withURL: URL(string: (avatarURL))!,
                placeholderImage: nil,
                filter: nil,
                progress: nil,
                progressQueue: DispatchQueue.main,
                imageTransition: UIImageView.ImageTransition.noTransition,
                runImageTransitionIfCached: false,
                completion: { [weak self] image in
                    self?.avatarsCache[avatarURL] = forCell.userImageView.image!
            })
        }
    }
    
    
    // MARK: - Helpers
    func userFromIndexPath(_ indexPath: IndexPath) -> User! {
        return self.users[indexPath.row]
    }
}
