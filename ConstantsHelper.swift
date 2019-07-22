//
//  ConstantsHelper.swift
//  scrum-ios
//
//  Created by Matias Glessi on 6/4/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit

class ConstantsHelper {
    
    enum LevelStatus {
        static let notStarted = "NO INICIADO"
        static let started = "EN CURSO"
        static let blocked = "BLOQUEADO"
    }
    

    enum Storyboard {
        static let main = "Main"
        static let levels = "Levels"
        static let sublevels = "SubLevel"
        static let tutorial = "Tutorial"
    }

    
    
    static var levels: [Level] = []
    static var sublevels: [SubLevel] = []
    
    
    static let SublevelCompletedInfo = "com.matiasglessi.scrum.sublevelCompletedInfo"

    //Level 1
    static func getShippingIncrementOriginalPoint() -> CGPoint {
        
        
        let device = Device()
        
        if device == .iPhone5 || device == .iPhone5s || device == .iPhone5c
        {
            return CGPoint.init(x: 281, y: 255)
        }
        else {
            return CGPoint.init(x: 369, y: 255)

        }
//
//        else if  device == .iPhone6 || device == .iPhone6s || device == .iPhone7
//        {
//            return CGPoint.init(x: 355, y: 255)
//        }
//        else if  device == .iPhone6Plus || device == .iPhone6sPlus || device == .iPhone7Plus
//        {
//            return CGPoint.init(x: 369, y: 255)
//        }
//        return CGPoint.init()
    }
    
    static func getProductBacklogOriginalPoint() -> CGPoint {
        
        let device = Device()
        
        if device == .iPhone5 || device == .iPhone5s || device == .iPhone5c
        {
            return CGPoint.init(x: 30, y: 263)
        }
        else {
            return CGPoint.init(x: 36, y: 269)
        }
//        else if  device == .iPhone6 || device == .iPhone6s || device == .iPhone7
//        {
//            return CGPoint.init(x: 36, y: 267)
//        }
//        else if  device == .iPhone6Plus || device == .iPhone6sPlus || device == .iPhone7Plus
//        {
//            return CGPoint.init(x: 36, y: 269)
//        }
//        return CGPoint.init()
    }
    
    static func getSprintBacklogOriginalPoint() -> CGPoint {
        
        let device = Device()
        
        if device == .iPhone5 || device == .iPhone5s || device == .iPhone5c
        {
            return CGPoint.init(x: 111, y: 265)
        }
        else {
            return CGPoint.init(x: 143, y: 270)
        }
//        else if  device == .iPhone6 || device == .iPhone6s || device == .iPhone7
//        {
//            return CGPoint.init(x: 131, y: 272)
//        }
//        else if  device == .iPhone6Plus || device == .iPhone6sPlus || device == .iPhone7Plus
//        {
//            return CGPoint.init(x: 143, y: 270)
//        }
//        return CGPoint.init()
        
//        return CGPoint.init(x: 131, y: 272)
    }
    
    static func getSprintOriginalPoint() -> CGPoint {
        
        let device = Device()
        
        if device == .iPhone5 || device == .iPhone5s || device == .iPhone5c
        {
            return CGPoint.init(x: 207, y: 212)
        }
        else {
            return CGPoint.init(x: 268, y: 213)
        }
//        else if  device == .iPhone6 || device == .iPhone6s || device == .iPhone7
//        {
//            return CGPoint.init(x: 243, y: 212)
//        }
//        else if  device == .iPhone6Plus || device == .iPhone6sPlus || device == .iPhone7Plus
//        {
//            return CGPoint.init(x: 268, y: 213)
//        }
//        return CGPoint.init()
    }
    
    static func getDailyOriginalPoint() -> CGPoint {
        
        let device = Device()
        
        if device == .iPhone5 || device == .iPhone5s || device == .iPhone5c
        {
            return CGPoint.init(x: 109, y: 105)
        }
        else {
            return CGPoint.init(x: 149, y: 105)
        }
//        else if  device == .iPhone6 || device == .iPhone6s || device == .iPhone7
//        {
//            return CGPoint.init(x: 129, y: 114)
//        }
//        else if  device == .iPhone6Plus || device == .iPhone6sPlus || device == .iPhone7Plus
//        {
//            return CGPoint.init(x: 149, y: 105)
//        }
//        return CGPoint.init()
    }
    
}


extension Notification.Name {
    public static let SublevelCompleted = Notification.Name.init("com.matiasglessi.scrum.SublevelCompleted")
    public static let UserLoggedIn = Notification.Name.init("com.matiasglessi.scrum.UserLoggedIn")

}

