//
//  SubLevelLogicViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/26/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class SubLevelLogicViewController: UIViewController, BaseVMDelegate, Storyboarded {
    

    var sublevel = SubLevel()
    var viewModel = SubLevelVM()
    var theoryCancelled = false


    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if theoryCancelled {
            theoryCancelled = false
            self.goBack()
            return
        }
        
        
        if !sublevel.theoryWatched {
            // getTheory
//            self.viewModel.fetchStepsFor(sublevel: self.sublevel)
            return
        }
        // getPractice
//        self.viewModel.fetchGamesFor(sublevel: self.sublevel)

    }
    
//    // MARK: - SublevelInformationChangeDelegate
//
//    func userCompletedTheory() {
//        sublevel.theoryWatched = true
//    }
//
//    func userCancelledTheory() {
//        self.theoryCancelled = true
//    }

    
    // MARK: - BaseVMDelegate

    func didFinishTask(sender: BaseVM, errorMessage: String?, dataArray: [NSObject]?) {
        
        let levelStoryboard = UIStoryboard.init(name: "Tutorial", bundle: nil)

        if !sublevel.theoryWatched {
            
            let sublevelViewController = levelStoryboard.instantiateViewController(withIdentifier: "TheoryViewController") as! TheoryViewController
            
            sublevelViewController.theorySteps = dataArray as! [Step]
//            sublevelViewController.subLevelDelegate = self
            self.navigationController?.pushViewController(sublevelViewController, animated: true)
            return
        }
        
        
        
        
        let gameVC = levelStoryboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        gameVC.games = dataArray as! [Game]

        self.navigationController?.pushViewController(gameVC, animated: true)

        
        
        
        // go to first game
    }
    
    private func goBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
}
