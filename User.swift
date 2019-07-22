//
//  User.swift
//  scrum-ios
//
//  Created by Matias on 02/02/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.


import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var mail: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var profession: String = ""
    @objc dynamic var uid: String = ""
    
    
    func initFrom(json: JSON){
        self.name = json["name"].stringValue
        self.mail = json["mail"].stringValue
        self.age = json["age"].intValue
        self.profession = json["profession"].stringValue
        self.uid = json["uid"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "uid"
    }
    

}

/*

class User: NSObject, NSCoding  {
    
    var name: String
    var mail: String
    var age: Int
    var profession: String
    var uid: String
    
    
    init(name: String, mail: String, age: Int, profession: String, uid: String) {
        self.name = name
        self.mail = mail
        self.age = age
        self.profession = profession
        self.uid = uid
    }
    
    init?(json: JSON) {
        self.name = json["name"].stringValue
        self.mail = json["mail"].stringValue
        self.age = json["age"].intValue
        self.profession = json["profession"].stringValue
        self.uid = json["uid"].stringValue

    }

    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String
            else { return nil }
        guard let mail = decoder.decodeObject(forKey: "mail") as? String
            else { return nil }
        guard let profession = decoder.decodeObject(forKey: "profession") as? String
            else { return nil }
        guard let uid = decoder.decodeObject(forKey: "uid") as? String
            else { return nil }
        
        self.init(name: name, mail: mail, age: decoder.decodeInteger(forKey: "age"), profession: profession, uid: uid)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.mail, forKey: "mail")
        aCoder.encode(self.age, forKey: "age")
        aCoder.encode(self.profession, forKey: "profession")
        aCoder.encode(self.uid, forKey: "uid")
    }


    func saveToDefaults() {
        let defaults = UserDefaults.standard
        let userData = NSKeyedArchiver.archivedData(withRootObject: self)
        defaults.set(userData, forKey: "user")
    }

    func loadFromDefaults() -> User? {
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: "user") as? Data else {
            return nil
        }

        guard let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User else {
            return nil
        }
        return user
    }
    
}
 
 */
