//
//  TheoryCoordinator.swift
//  scrum-ios
//
//  Created by Matias on 06/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import UIKit

class TheoryCoordinator: Coordinator {
    
    weak var parentCoordinator: SublevelCoordinator?
    
    var childCoordinators = [Coordinator]()
    var steps = [Step]()
    var sublevel: SubLevel?
    var level: Level?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let vc = TheoryViewController.instantiate(for: ConstantsHelper.Storyboard.tutorial)
        vc.theorySteps = steps
        vc.sublevel = sublevel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func didFinishTurorial(){
        
        if let level = level, let sublvl = sublevel {
            
            let newProgress: [String : Any] = [
                "level_number": level.id ?? 0,
                "actual_sublevel": sublvl.id,
                "tutorial_completed": true,
                "actual_game": 0,
                "total_games": sublvl.games?.count ?? 1
            ]
            
            RealmService.saveProgress(with: newProgress)
        }
        
        finishTutorial()
    }
    
    func didSkippedTutorial(){
        if let level = level, let sublvl = sublevel {
            LogService.tutorialSkipped(level: level.id ?? 0 , sublevel: sublvl.id)
            
            let newProgress: [String : Any] = [
                "level_number": level.id ?? 0,
                "actual_sublevel": sublvl.id,
                "tutorial_completed": true,
                "actual_game": 0,
                "total_games": sublvl.games?.count ?? 1

            ]
            
            RealmService.saveProgress(with: newProgress)
        }
        finishTutorial()
        
    }
    
    
    func finishTutorial(){
        parentCoordinator?.didFinishTutorial(self)
    }
    
    func didExitTutorial(){
        parentCoordinator?.didExitTutorial(self)
    }
    
}
