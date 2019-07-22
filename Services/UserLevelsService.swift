//
//  UserLevelsService.swift
//  scrum-ios
//
//  Created by Matias on 09/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import SwiftyJSON
import RealmSwift

class UserLevelsService {
    
    static let db = Firestore.firestore()

    static let initialProgress: [String: Any] = [
        "level_number": 1,
        "blocked": false,
        "status": ConstantsHelper.LevelStatus.notStarted,
        "tutorial_completed": false,
        "actual_sublevel": 0,
        "actual_game": 0
    ]
    

  
    static func createUserDocument(mail: String, userData: [String: Any], completionHandler: @escaping (Error?) -> Void) {
        
        RealmService.saveProgress(with: initialProgress)

        db.collection("users").document(mail).setData(userData) { (error) in
            if let err = error {
                print("Error adding document: \(err)")
                completionHandler(err)
             } else {
                print("Document added!")
                
                self.updateLevel(level: "level_1", for: mail, with: initialProgress)
                completionHandler(nil)
            }
        }

    }
    
    static func updateLevel(level: String, for mail: String, with data: [String: Any]) {
        db.collection("users/\(mail)/levels").document(level).setData(data)
    }
    
    
    static func getMainLevelsInfo(mail: String, userData: [String: Any], completionHandler: @escaping (Error?) -> Void) {
        
        db.collection("users").document(mail).collection("levels").getDocuments(completion: { (query, error) in
            
            if let error = error {
                completionHandler(error)
            }
            else {
                for doc in (query?.documents)! {
                    let jsonObj = JSON.init(doc.data())
                    print(jsonObj)
                    let actualLevel = jsonObj["level_number"].intValue
                    
                    if actualLevel != 0 {
                        ConstantsHelper.levels[actualLevel - 1].update(json: jsonObj)
                    }
                    
                }
            }
        })
    }
    
    static func getUser(mail: String, completionHandler: @escaping (Error?, User?) -> Void) {
    
        db.collection("users").document(mail).getDocument { (document, err) in
            if let error = err {
                completionHandler(error, nil)
            }
            else {

                if let doc = document {
                    
                    let user = User()
                    user.initFrom(json: JSON.init(doc.data() ?? [:]))
                    completionHandler(nil, user)
                }
            }
        }
    }
    
    static func getProgressesFor(userMail: String, completionHandler: @escaping (Error?) -> Void) {
        
        db.collection("users").document(userMail).collection("levels").getDocuments(completion: { (query, error) in
            
            if let error = error {
                completionHandler(error)
            }
            else {
                for doc in (query?.documents)! {

                    let progress = Progress()
                    progress.initFrom(json: JSON.init(doc.data()))
                    
                    RealmService.saveProgress(with: progress)
                }
                completionHandler(nil)

            }
        })
    }
}
