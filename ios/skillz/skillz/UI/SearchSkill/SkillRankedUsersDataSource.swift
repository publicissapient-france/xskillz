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
    
    // MARK: - Init
    init(domain: Domain?, users: [User]!) {
        self.domain = domain
        self.users = users
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCollectionViewCell", forIndexPath: indexPath) as! UserCollectionViewCell
        let user = self.userFromIndexPath(indexPath)
        
        cell.user = user
        if self.domain != nil {
            cell.color = self.domain!.colorObject
        }
        cell.loadAvatar()
        
        return cell
    }
    
    
    // MARK: - Helpers
    func userFromIndexPath(indexPath: NSIndexPath) -> User! {
        return self.users[indexPath.row]
    }
}
