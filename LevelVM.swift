//
//  LevelVM.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/6/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseAuth

class LevelVM: BaseVM {
    
    var progresses: [Progress] = []
    var levels: [Level] = []
    
    let levelColors: [UIColor] = [UIColor(red:1.00, green:0.65, blue:0.10, alpha:1.0), UIColor(red:0.37, green:0.55, blue:0.38, alpha:1.0), UIColor(red:0.94, green:0.44, blue:0.42, alpha:1.0), UIColor(red:0.62, green:0.68, blue:0.78, alpha:1.0), UIColor(red:0.09, green:0.47, blue:0.58, alpha:1.0), UIColor(red:0.56, green:0.18, blue:0.34, alpha:1.0), UIColor(red:0.47, green:0.71, blue:0.45, alpha:1.0)]

    
    var totalLevels: Int {
        return levels.count
    }
    
    
    func getLevels() {
        
        SystemLevelsService.getLevels { (levels, error) in
            if error == nil {
                self.levels = levels
                if let user = Auth.auth().currentUser {
                    UserLevelsService.getProgressesFor(userMail: user.email!) { (error) in
                        if error == nil {
                            self.progresses = self.getProgresses()
                            self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: [])
                        }
                    }
                }
                
            }
        }
    }
    
    
    func getProgresses() -> [Progress] {
        let realm = try! Realm()
        let objects = realm.objects(Progress.self).toArray(ofType: Progress.self) as [Progress]
        return objects.count > 0 ? objects : []
    }

    
    
    func progressFor(level: Int) -> Progress? {
        
        if !(progresses.count > 0) { return nil }
        
        if level > progresses.count - 1 { return nil }

        return progresses[level]
    
    }

    
    func isLevelLocked(level: Level) -> Bool {
        
        guard let locked = level.blocked else { return true }
        return locked
    }
    
}
