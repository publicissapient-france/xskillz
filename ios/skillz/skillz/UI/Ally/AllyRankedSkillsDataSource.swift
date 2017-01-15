//
//  AllyRankedSkillsDataSource.swift
//  XSkillz
//
//  Copyright © 2016 Xebia IT Architects. All rights reserved.
//

import UIKit

class AllyRankedSkillsDataSource: NSObject, UICollectionViewDataSource {
    var domain: Domain?
    var skills: [Skill]!
    
    // MARK: - Init
    init(domain: Domain?, skills: [Skill]!) {
        self.domain = domain
        self.skills = skills
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SkillCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCollectionViewCell", for: indexPath) as! SkillCollectionViewCell
        let skill = self.skillFromIndexPath(indexPath)
        
        cell.skill = skill
        if self.domain != nil {
            cell.color = self.domain!.colorObject
        }
        
        return cell
    }
    
    
    // MARK: - Helpers
    func skillFromIndexPath(_ indexPath: IndexPath) -> Skill! {
        return self.skills[indexPath.row]
    }
}
