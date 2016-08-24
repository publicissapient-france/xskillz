//
//  AllyRankedSkillsDataSource.swift
//  XSkillz
//
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyRankedSkillsDataSource: NSObject, UICollectionViewDataSource {
    var domain: Domain!
    var skills: [Skill]!
    
    // MARK: - Init
    init(domain: Domain!, skills: [Skill]!) {
        self.domain = domain
        self.skills = skills
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SkillCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SkillCollectionViewCell", forIndexPath: indexPath) as! SkillCollectionViewCell
        let skill = self.skillFromIndexPath(indexPath)
        
        cell.skill = skill
        cell.color = self.domain.colorObject
        
        return cell
    }
    
    
    // MARK: - Helpers
    func skillFromIndexPath(indexPath: NSIndexPath) -> Skill! {
        return self.skills[indexPath.row]
    }
}