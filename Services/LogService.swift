//
//  LogService.swift
//  scrum-ios
//
//  Created by Matias on 02/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class LogService {

    static let db = Firestore.firestore()
    


    static func gameCorrectInFirstTryAnswer(level: Int, sublevel: Int, game: Int, time: Int) {
        
        let eventData: [String: Any] = [
            "uuid": Auth.auth().currentUser?.uid ?? "-",
            "type": "gameCorrectInFirstTryAnswer",
            "value": "\(time)",
            "level": level,
            "sublevel": sublevel,
            "game": game
        ]
        
        Analytics.logEvent("gameCorrectInFirstTryAnswer", parameters: eventData)
        
    }
    
    
    static func gameCorrectAnswer(level: Int, sublevel: Int, game: Int, time: Int) {
        
        let eventData: [String: Any] = [
            "uuid": Auth.auth().currentUser?.uid ?? "-",
            "type": "gameCorrectAnswer",
            "value": "\(time)",
            "level": level,
            "sublevel": sublevel,
            "game": game
        ]
        
        Analytics.logEvent("gameCorrectAnswer", parameters: eventData)
        
    }

    
    static func gameWrongAnswer(level: Int, sublevel: Int, game: Int, time: Int) {
        
        let eventData: [String: Any] = [
            "uuid": Auth.auth().currentUser?.uid ?? "-",
            "type": "gameWrongAnswer",
            "value": "\(time)",
            "level": level,
            "sublevel": sublevel,
            "game": game
        ]
        
        Analytics.logEvent("gameWrongAnswer", parameters: eventData)

    }
    
    static func gameTimeSpent(level: Int, sublevel: Int, game: Int, time: Int) {
        
        let eventData: [String: Any] = [
            "uuid": Auth.auth().currentUser?.uid ?? "-",
            "type": "gameTimeSpent",
            "value": "\(time)",
            "level": level,
            "sublevel": sublevel,
            "game": game
        ]
        
        Analytics.logEvent("gameTimeSpent", parameters: eventData)

    }
    
    static func tutorialTimeSpent(level: Int, sublevel: Int, time: Int) {
        
        let eventData: [String: Any] = [
            "uuid": Auth.auth().currentUser?.uid ?? "-",
            "type": "tutorialTimeSpent",
            "value": "\(time)",
            "level": level,
            "sublevel": sublevel,
            "game": 0
        ]

        Analytics.logEvent("tutorialTimeSpent", parameters: eventData)
        
    }
    
    static func tutorialSkipped(level: Int, sublevel: Int) {
        
        let eventData: [String: Any] = [
            "uuid": Auth.auth().currentUser?.uid ?? "-",
            "type": "tutorialSkipped",
            "value": "true",
            "level": level,
            "sublevel": sublevel,
            "game": 0
        ]
        
        Analytics.logEvent("tutorialSkipped", parameters: eventData)

    }
    
}
