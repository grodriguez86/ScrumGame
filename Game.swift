//
//  Game.swift
//  scrum-ios
//
//  Created by Matias on 02/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Game: BaseModel {
    
    var content: [Content] = []
    var code: String = ""
    var gameType: GameType = .quiz
    var title: String = ""
    
    var id: Int {
        return getId()
    }
    
    override init() {}
    
    init?(json: JSON) {
        super.init()
        self.title = json["title"].stringValue
        self.code = json["code"].stringValue
        self.gameType = GameType(rawValue: json["type"].stringValue)!
        self.content = json["content"].arrayValue.compactMap { Content(json: $0) }
    }
    
    
    fileprivate func getId() -> Int{
        
        let values = code.components(separatedBy: ".")
        
        if values.count > 2, let result = Int(values[2]) {
            return result
        }
        return 0
    }
}

enum GameType: String {
    
    case quiz = "quiz"
    case draggable = "draggable"
    case imageQuiz = "imageQuiz"
    case textQuiz = "textQuiz"
    case buttonsQuiz = "buttonsQuiz"
    
}
