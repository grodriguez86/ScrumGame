//
//  SublevelCoordinator.swift
//  scrum-ios
//
//  Created by Matias on 10/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit

class SublevelCoordinator: Coordinator {
    
    weak var parentCoordinator: LevelsCoordinator?
    weak var sublevel: SubLevel?
    weak var level: Level?
    weak var progress: Progress?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        
        guard let level = level else {
            back()
            return
        }
 
        RealmService.getProgress(for: level) { (progress, error) in
            if let prog = progress {
                self.progress = prog
                
                if prog.tutorial_completed {
                    self.showGame()
                }
                else {
                    if let steps = self.sublevel?.theoricalSteps {
                        self.showTutorial(steps: steps)
                    }
                }
                
            }
        }
    }
    
    func showTutorial(steps: [Step]){
        
        
        let child = TheoryCoordinator.init(navigationController: navigationController)
        child.parentCoordinator = self
        child.steps = steps
        child.sublevel = sublevel
        child.level = level
        childCoordinators.append(child)
        child.start()
    }
    
    func showGame() {
        
        
        if let sublevel = sublevel,
            let level = level {
            let child = GameCoordinator.init(navigationController: navigationController)
            child.parentCoordinator = self
            child.levelValue = level.id
            child.sublevelValue = sublevel.id
            child.gamesLeftToPlay = sublevel.games ?? []
            childCoordinators.append(child)
            child.start()
        }
    }
    
    
    func didFinishTutorial(_ coordinator: TheoryCoordinator) {
        childDidFinish(coordinator)
        showGame()
    }
    
    
    func didExitGame(_ coordinator: GameCoordinator) {
        childDidFinish(coordinator)
        backToSublevel()
    }
    
    func didExitTutorial(_ coordinator: TheoryCoordinator) {
        childDidFinish(coordinator)
        backToSublevel()
    }

    func didFinishSublevel(){
        
        // TODO: Complete sublevel flow.
        backToSublevel()
    }
    
    
    func backToSublevel(){
        
        for controller in navigationController.viewControllers as Array {
            if controller.isKind(of: SubLevelViewController.self) {
                _ =  navigationController.popToViewController(controller, animated: true)
                break
            }
        }
        
    }


    
}
