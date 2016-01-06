//
//  RealmStore.swift
//  skillz
//
//  Created by Florent Capon on 22/12/2015.
//  Copyright © 2015 Xebia IT Architects. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmStore : NSObject {
    
    public static func inMemoryStore() throws -> Realm {
        do {
            let realm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: "InMemory"))
            return realm
        } catch let error as NSError {
            throw error
        }
    }
    
    public static func persistStore() throws -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch let error as NSError {
            throw error
        }
    }
}