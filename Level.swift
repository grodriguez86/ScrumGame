//
//  Level.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/2/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseModel: NSObject { }

class Level: BaseModel {
    
    var sublevels: [SubLevel] = []
    var id: Int?
    var title: String?

    var blocked: Bool?
    var levelStatus: ConstantsHelper.LevelStatus?
    var actual_game: Int?
    var actual_sublevel: Int?
    var level_number: Int?
    var tutorial_completed: Bool?
    
    override init() {}
    
    init?(json: JSON) {
        super.init()
        self.title = json["name"].stringValue
        self.id = json["code"].intValue
        self.sublevels = json["sublevels"].arrayValue.compactMap { SubLevel(json: $0) }
    }
    
    func update(json: JSON) {
        self.blocked = json["blocked"].boolValue
//        self.levelStatus =  ConstantsHelper.LevelStatus.notStarted //json["status"].stringValue
        self.actual_game = json["actual_game"].intValue
        self.actual_sublevel = json["actual_sublevel"].intValue
        self.level_number = json["level_number"].intValue
        self.tutorial_completed = json["tutorial_completed"].boolValue

    }
    
   
    
    
    
    func percentage(from progress: Progress) -> Int {
        
        let totalSublevels = self.sublevels.count
        
        let sublevelsCompleted = getSublevelsCompletedCount(progress)
        
        let total = totalSublevels * 100
        
        let actualSublevelPercentage = getCurrentSublevelPercentage(progress)
        
        let doneSoFar = 100 * sublevelsCompleted + actualSublevelPercentage
        
        return Int(floor(CGFloat(doneSoFar * 100) / CGFloat(total)))
        
    }
    
    fileprivate func getCurrentSublevelPercentage(_ progress: Progress) -> Int {
        
        if progress.sublevel_id == 0 { return 0 }
        
        return self.sublevels[progress.sublevel_id].percentage(from: progress)
    }

    
    fileprivate func getSublevelsCompletedCount(_ progress: Progress) -> Int {
        return progress.sublevel_id == 1 || progress.sublevel_id == 0 ? 0 : progress.sublevel_id - 1
    }
    
}
