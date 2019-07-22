//
//  LevelsCoordinator.swift
//  scrum-ios
//
//  Created by Matias on 10/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit

class LevelsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    weak var parentCoordinator: AppCoordinator?

    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func fetchProgresses() {
        
    }
    
    func start() {
        let vc = LevelsViewController.instantiate(for: ConstantsHelper.Storyboard.levels)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func didFinishDeauthenticating(){
        self.parentCoordinator?.didFinishDeauthenticating()
    }
    
    func openLevel(level: Level, color: UIColor){

        let vc = SubLevelViewController.instantiate(for: ConstantsHelper.Storyboard.sublevels)
        vc.coordinator = self
        vc.view.backgroundColor = color
        vc.currentLevel = level
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openSublevel(level: Level, sublevel: SubLevel) {
        let child = SublevelCoordinator.init(navigationController: navigationController)
        child.parentCoordinator = self
        child.sublevel = sublevel
        child.level = level
        childCoordinators.append(child)
        child.start()
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a initial or levels
        
        
        if let signUpViewController = fromViewController as? SignUpViewController {
            childDidFinish(signUpViewController.coordinator)
            print("Removing CredentialsCoordinator for SignUpVC")
        }
        
        if let loginViewController = fromViewController as? LoginViewController {
            childDidFinish(loginViewController.coordinator)
            print("Removing CredentialsCoordinator for LoginVC")
        }
        
        
        if let levelsViewController = fromViewController as? LevelsViewController {
            childDidFinish(levelsViewController.coordinator)
            print("Removing CredentialsCoordinator for LevelsVC")
            
        }
        
        
        
    }



}
