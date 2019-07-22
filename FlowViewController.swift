//
//  FlowViewController.swift
//  scrum-ios
//
//  Created by Matias on 02/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit

class FlowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") {
            let storyboard = UIStoryboard.init(name: "Levels", bundle: nil)
            let levelsViewController = storyboard.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
            self.navigationController?.pushViewController(levelsViewController, animated: true)
        }
        else {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let initialVC = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
            self.navigationController?.pushViewController(initialVC, animated: true)
        }
    }

}
