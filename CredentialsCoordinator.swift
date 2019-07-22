//
//  CredentialsCoordinator.swift
//  scrum-ios
//
//  Created by Matias on 10/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit

class CredentialsCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = InitialViewController.instantiate(for: ConstantsHelper.Storyboard.main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func register() {
        let vc = SignUpViewController.instantiate(for: ConstantsHelper.Storyboard.main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func login() {
        let vc = LoginViewController.instantiate(for: ConstantsHelper.Storyboard.main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func didFinishAuthentication(){
        self.parentCoordinator?.didFinishAuthenticating()
    }
    
}
