//
//  RealmService.swift
//  scrum-ios
//
//  Created by Matias on 02/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class RealmService {
    
    fileprivate static func saveToRealm(_ user: User) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(user, update: true)
        }
    }

    fileprivate static func saveToRealm(_ progress: Progress) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(progress, update: true)
        }
    }
    
    
    static func getProgress(for level: Level, completionHandler: @escaping (Progress?, Error?) -> Void) {
    
        guard let levelValue = level.id else { return }
       
        let realm = try! Realm()
        let progress = realm.object(ofType: Progress.self, forPrimaryKey: levelValue)
        completionHandler(progress, nil)
    }
    
    static func saveProgress(with data: [String: Any]) {
        let progress = Progress()
        progress.initFrom(json: JSON.init(data))
        
        saveToRealm(progress)
    }
    
    static func saveProgress(with progress: Progress) {
        saveToRealm(progress)
    }
    
    static func saveUser(with user: User) {
        saveToRealm(user)
    }
    
    static func saveUser(with data: [String: Any]) {
        let user = User()
        user.initFrom(json: JSON.init(data))
        
        saveToRealm(user)

    }
    
    
    
    
    
    

    
}
