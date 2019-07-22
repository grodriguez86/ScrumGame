//
//  GameViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/29/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit
import Bartinter

class GameViewController: UIViewController, GameManagerDelegate, Storyboarded {

    @IBOutlet weak var sublevelTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    var games: [Game] = []
    var currentGame: Game?
    var currentGameIndex: Int = 0
    
    weak var coordinator: GameCoordinator?

    
    // Draggable Scrum Flow Game
    private lazy var scrumFlowViewController: L1S1ViewController = {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "L1S1") as! L1S1ViewController
        viewController.gameDelegate = self
        self.add(asChildViewController: viewController)
        return viewController
    }()

    // Generic Quiz Game
    private lazy var quizViewController: QuizGameViewController = {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "QuizGameViewController") as! QuizGameViewController
        viewController.gameDelegate = self
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    
    // Squared Quiz Game
    private lazy var squaredQuizViewController: SquaredQuizGameViewController = {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SquaredQuizGameViewController") as! SquaredQuizGameViewController
        viewController.gameDelegate = self
        self.add(asChildViewController: viewController)
        return viewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatesStatusBarAppearanceAutomatically = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentGame = games[currentGameIndex]
        prepareFor(game: currentGame)
    }
    
    @IBAction func close(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Estas seguro de salir?", message: "Si sales perderas el progreso del juego actual.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil)
        
        let defaultAction = UIAlertAction.init(title: "Aceptar", style: .default) { (_) in
            self.coordinator?.didExitCurrentGame()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    // MARK: - GameManagerDelegate

    func prepareForNextGame() {
        self.saveProgress()
        self.removeCurrentGame()
        self.prepareNextViewController()
    }
    
    
    // MARK: - Private Methods

    private func removeCurrentGame() {
        
        if let currentGame = currentGame {
            switch currentGame.gameType {
            case .quiz:
                remove(asChildViewController: quizViewController)
            case .draggable:
                remove(asChildViewController: scrumFlowViewController)
            case .imageQuiz:
                remove(asChildViewController: squaredQuizViewController)
            case .textQuiz:
                remove(asChildViewController: squaredQuizViewController)
            case .buttonsQuiz:
                remove(asChildViewController: squaredQuizViewController)

            }
        }
    }
    
    private func prepareNextViewController() {
        
        currentGameIndex += 1
        
        if currentGameIndex < games.count {
            currentGame = games[currentGameIndex]
            prepareFor(game: currentGame)
        }
    
        else {
            
            print("SUBLEVEL COMPLETEEEEEEEEDDDDDD")
            saveProgress()


            coordinator?.didFinishAllGames()
        }
    }
    
    
    
    func prepareFor(game: Game?) {
        if let currentGame = game {
            switch currentGame.gameType {
            case .quiz:
                add(asChildViewController: quizViewController)
            case .draggable:
                add(asChildViewController: scrumFlowViewController)
            case .imageQuiz:
                add(asChildViewController: squaredQuizViewController)
            case .textQuiz:
                add(asChildViewController: squaredQuizViewController)
            case .buttonsQuiz:
                add(asChildViewController: squaredQuizViewController)
            }
        }
    }
    
    
    
    private func saveProgress() {
        
        if let levelValue = self.coordinator?.levelValue,
            let sublevelValue = self.coordinator?.sublevelValue {
            
            let newProgress: [String : Any] = [
                "level_number": levelValue,
                "actual_sublevel": sublevelValue,
                "tutorial_completed": true,
                "actual_game": currentGameIndex,
                "total_games": games.count,
            ]
            
            RealmService.saveProgress(with: newProgress)
        }
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
        
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleBottomMargin] // = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }


}


protocol GameManagerDelegate: class {
    
    func prepareForNextGame()
    
}


struct SublevelCompletedInfo {
    
    var newPercentage: Int
    var sublevelNumber: Int
    
}
