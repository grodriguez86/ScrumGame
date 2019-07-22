//
//  TheoryViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/23/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit
import Bartinter

class TheoryViewController: UIViewController, Storyboarded {

    weak var coordinator: TheoryCoordinator?
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageNextButton: UIButton!
    @IBOutlet weak var pageBackButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var letsPlayButton: UIButton!

    var theorySteps: [Step] = []
    var sublevel: SubLevel?
//    weak var subLevelDelegate: SublevelInformationChangeDelegate?

    
    var theoryPageViewController: TheoryPageViewController? {
        didSet {
            theoryPageViewController?.tutorialDelegate = self
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.letsPlayButton.hide()
        updatesStatusBarAppearanceAutomatically = true
        pageControl.addTarget(self, action: #selector(TheoryViewController.didChangePageControlValue), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: Add loader animation.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let theoryPageViewController = segue.destination as? TheoryPageViewController {
            self.theoryPageViewController = theoryPageViewController
            self.theoryPageViewController?.steps = theorySteps
        }
    }
    
    
    
    @IBAction func skipTheory(_ sender: Any) {
        
        coordinator?.didSkippedTutorial()
        
    }
    
    @IBAction func goBackToSublevels(_ sender: Any) {
        
        coordinator?.didExitTutorial()
    }
    
    @IBAction func next(_ sender: Any) {
        
        if pageControl.currentPage + 1 == pageControl.numberOfPages {
            // User ended theory.
            coordinator?.didFinishTurorial()
            return
        }
        
        theoryPageViewController?.scrollToNextViewController()

    }

    @IBAction func back(_ sender: Any) {
        theoryPageViewController?.scrollToBackViewController()

    }
    
    @IBAction func play(_ sender: Any) {
        coordinator?.didFinishTurorial()
    }
    
//    func goBackToLogic(theoryCompleted: Bool, userCancelled: Bool){
//
//        if userCancelled { subLevelDelegate?.userCancelledTheory() }
//
//        if theoryCompleted { subLevelDelegate?.userCompletedTheory() }
//
//        self.navigationController?.popViewController(animated: true)
//
//    }
//
    @objc func didChangePageControlValue() {
        theoryPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }

    
    func tutorialPageViewController(didUpdateTo status: PagerStatus) {
        
        switch status {
        case .firstPage:
            self.pageBackButton.hide()
            self.pageNextButton.show()
            self.letsPlayButton.hide()
            self.skipButton.show()

        case .lastPage:
            self.pageBackButton.show()
            self.pageNextButton.hide()
            self.letsPlayButton.show()
            self.skipButton.hide()
        default:
            self.pageBackButton.show()
            self.letsPlayButton.hide()
            self.pageNextButton.show()
            self.skipButton.show()


        }

    
    }
}





extension TheoryViewController: TheoryPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: TheoryPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: TheoryPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        
        if index == 0 {
            self.tutorialPageViewController(didUpdateTo: .firstPage)
        }
        else if index + 1 == pageControl.numberOfPages {
            self.tutorialPageViewController(didUpdateTo: .lastPage)
        }
        else {
            self.tutorialPageViewController(didUpdateTo: .middle)
        }
    }
}

//
//protocol SublevelInformationChangeDelegate: class {
//
//    func userCompletedTheory()
//    func userCancelledTheory()
//
//}



enum PagerStatus {
    case firstPage
    case lastPage
    case middle
}
