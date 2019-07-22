//
//  LoginViewController.swift
//  scrum-ios
//
//  Created by Matias on 13/01/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import RealmSwift

class LoginViewController: UIViewController, GIDSignInUIDelegate, Storyboarded {

    weak var coordinator: CredentialsCoordinator?
    
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    
    var googleSigninIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(goToMainLevelsViewController), name: Notification.Name.UserLoggedIn, object: nil)
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if !googleSigninIn {
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UserLoggedIn, object: nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.coordinator?.back()
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        if (mailTextField.text != "" && passwordTextField.text != "") {
            
            Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if let _ = user {
                    
                    
                        // TODO! Levantar info de los progress de Firestore y guardarla en realm.∫ø∫Ω
                    
                    
                    
                    UserLevelsService.getUser(mail: self.mailTextField.text!, completionHandler: { (error, user) in
                        
                        if error != nil {
                            UserLevelsService.getProgressesFor(userMail: (user?.mail)!, completionHandler: { (error) in
                                if error != nil {
                                    RealmService.saveUser(with: user!)
                                    
                                }
                            })
                            self.goToMainLevelsViewController()
                        }
                        else {
                            //error tratando de obtener al user, ir igual al main  pero con error
                            self.goToMainLevelsViewController()
                        }
                    })
                }
                else {
                    print(error)
                }

            }
        }
    }
    
    
    @IBAction func googleLogIn(_ sender: Any) {
        googleSigninIn = true
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc private func goToMainLevelsViewController() {
        googleSigninIn = false
        coordinator?.didFinishAuthentication()

//        let storyboard = UIStoryboard.init(name: "Levels", bundle: nil)
//        let levelsViewController = storyboard.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
//        self.navigationController?.pushViewController(levelsViewController, animated: true)
        
        

    }

}
