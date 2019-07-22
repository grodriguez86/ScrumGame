//
//  SystemLevelsService.swift
//  scrum-ios
//
//  Created by Matias on 10/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import SwiftyJSON

class SystemLevelsService {
    
    
    static func getLevels(completionHandler: @escaping (_ levels: [Level], _ error: Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "db", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                let levels = jsonObj["levels"].arrayValue.compactMap { Level(json: $0) }
                
                completionHandler(levels, nil)
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completionHandler([], error)
                
            }
        } else {
            print("Invalid filename/path.")
            completionHandler([], NSError.init())
        }
        
    }
    
    
    static func getMainLevels(completionHandler: @escaping (Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "db", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                ConstantsHelper.levels = jsonObj["levels"].arrayValue.compactMap { Level(json: $0) }
                
                
                
                completionHandler(nil)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completionHandler(error)

            }
        } else {
            print("Invalid filename/path.")
            completionHandler(NSError.init())

        }
    }
    
    static func getSublevels(for level: Level ,completionHandler: @escaping (_ sublevels: [SubLevel], _ error: Error?) -> Void)  {
        if let path = Bundle.main.path(forResource: "db", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                if let levelValue = level.id {
                    let levelObj = jsonObj["levels"].arrayValue[levelValue - 1]
                    let sublevels = levelObj["sublevels"].arrayValue.compactMap { SubLevel(json: $0) }
                    completionHandler(sublevels, nil)
                }
                else {
                    completionHandler([], NSError.init())
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completionHandler([], error)
            }
        } else {
            print("Invalid filename/path.")
            completionHandler([], NSError.init())
        }

    }
    
    
}
