//
//  LoaderViewController.swift
//  scrum-ios
//
//  Created by Matias on 02/02/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoaderViewController: UIViewController {
    
    let firstLevelData: [[String : Any]] = [
        [
        "code": "1",
        "completed": false,
        "percent": 0,
        "locked": false
        ],
        [
        "code": "2",
        "completed": false,
        "percent": 0,
        "locked": true
        ]
    ]

    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        if UserDefaults.standard.bool(forKey: "comesFromRegister") {
            createFirebaseStructures()
        }
        else if UserDefaults.standard.bool(forKey: "comesFromLogin") {
            fetchDBData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    func createFirebaseStructures() {

        if let currentUser = Auth.auth().currentUser {
            db.collection("users").document(currentUser.uid).setData([
                "mail": currentUser.email ?? "",
                "name": currentUser.displayName ?? ""
                ])
        }
    }
    
    
    
    func fetchDBData() {
        
    }

    func goToMainLevel() {
        let storyboard = UIStoryboard.init(name: "Levels", bundle: nil)
        let levelsViewController = storyboard.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
        self.navigationController?.pushViewController(levelsViewController, animated: true)
    }
}
