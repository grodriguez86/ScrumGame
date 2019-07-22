//
//  Sublevel.swift
//  scrum-ios
//
//  Created by Matias on 02/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubLevel: BaseModel {
    
    var percentage: Int?
    var name: String?
    var code: String?
    var theoryWatched: Bool = false
    var theoricalSteps: [Step]?
    var games: [Game]?
    var id: Int {
        return getId()
    }
    var status: String {
        
        switch percentage {
        case 0?:
            return "INICIAR"
        case 100?:
            return "FINALIZADO"
        default:
            return "EN CURSO"
        }
        
    }
    
    override init() {}
    
    init?(json: JSON) {
        super.init()
        self.name = json["name"].stringValue
        self.code = json["code"].stringValue
        self.theoricalSteps = json["info_theory"].arrayValue.compactMap { Step(json: $0) }
        self.games = json["info_games"].arrayValue.compactMap { Game(json: $0) }
    }
    
    
    func percentage(from progress: Progress) -> Int {
        
        if progress.sublevel_id < id {
            return 100
        }
        else if progress.sublevel_id > id {
            return 0
        }
        else {
            let total = progress.total_games + 1
            let doneSoFar = progress.tutorial_completed ? progress.actual_game + 1 : progress.actual_game
            
            return Int(floor(CGFloat(doneSoFar * 100) / CGFloat(total)))
        }
    }
    
    fileprivate func getId() -> Int{
        
        guard let code = self.code else { return 0 }
        
        let values = code.components(separatedBy: ".")
        
        if values.count > 1, let result = Int(values[1]) {
            return result
        }
        return 0
    }
}
