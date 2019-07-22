//
//  InitialViewController.swift
//  scrum-ios
//
//  Created by Matias on 13/01/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, Storyboarded {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    weak var coordinator: CredentialsCoordinator?
    
    override func viewDidLoad() {
        logInButton.setBorder(width: 2.0, color: UIColor(red:0.24, green:0.50, blue:0.96, alpha:1.0).cgColor)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
    }
    
    @IBAction func logIn(_ sender: Any) {
        coordinator?.login()
    }
    
    @IBAction func register(_ sender: Any) {
        coordinator?.register()
    }
}


