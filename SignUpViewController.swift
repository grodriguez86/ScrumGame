//
//  SignUpViewController.swift
//  scrum-ios
//
//  Created by Matias on 13/01/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore
import SwiftyJSON
import RealmSwift

class SignUpViewController: UIViewController, GIDSignInUIDelegate, Storyboarded, UITextFieldDelegate {
    
    weak var coordinator: CredentialsCoordinator?

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    private let db = Firestore.firestore()
    var googleSigninIn = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(goToMainLevelsViewController), name: Notification.Name.UserLoggedIn, object: nil)
        mailTextField.delegate = self
        passwordTextField.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !googleSigninIn {
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UserLoggedIn, object: nil)
        }
    }

    @IBAction func back(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.coordinator?.back()
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let name = "Juancito"
        let age = 22
        let profession = "Ingenieria"
        
        if (mailTextField.text != "" && passwordTextField.text != "") {

            Auth.auth().createUser(withEmail: mailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error == nil {
                    
                    let newUserData: [String: Any] = [
                        "name": name,
                        "uid": result?.user.uid ?? "",
                        "age": age,
                        "profession": profession,
                        "mail": self.mailTextField.text!
                    ]

                    // Create user in local DB
                    RealmService.saveUser(with: newUserData)
                    
                    
                    // Create progress document in Firestore/LocalDB
                    UserLevelsService.createUserDocument(mail: self.mailTextField.text!, userData: newUserData, completionHandler: { (error) in
                        if let err = error {
                            let alertController = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else {
                            self.goToMainLevelsViewController()
                        }
                    })
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
