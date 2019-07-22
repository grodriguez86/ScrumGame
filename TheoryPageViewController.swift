//
//  TheoryPageViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/23/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class TheoryPageViewController: UIPageViewController {
    
    weak var tutorialDelegate: TheoryPageViewControllerDelegate?
    var steps: [Step] = []


    private(set) lazy var orderedViewControllers: [UIViewController] = {
        
        var vcs: [UIViewController] = []
        
        for step in self.steps {
            vcs.append(self.newTheoryStep(for: step))
        }
        
        return vcs
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            self.scrollToViewController(viewController: initialViewController)
        }
        
        tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            self.scrollToViewController(viewController: nextViewController)
        }
    }

    /**
     Scrolls to the previous view controller.
     */

    func scrollToBackViewController() {
        if let visibleViewController = viewControllers?.last,
            let previousViewController = pageViewController(self, viewControllerBefore: visibleViewController) {
            
//            let previousViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
//            self.scrollToViewController(⁄: previousViewController)
            self.scrollToViewController(viewController: previousViewController, direction: .reverse)

        }
    }

    
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            self.scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
//    private func newColoredViewController(color: String) -> UIViewController {
//        return UIStoryboard(name: "Tutorial", bundle: nil) .
//            instantiateViewController(withIdentifier: "\(color)ViewController")
//    }
    
   
    private func newTheoryStep(for step: Step) -> TheoryStepViewController {
        
        let vc = UIStoryboard(name: "Tutorial", bundle: nil) .
            instantiateViewController(withIdentifier: "TheoryStepViewController") as! TheoryStepViewController
        vc.step = step
        return vc
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    

    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
            
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension TheoryPageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]

    }

}


extension TheoryPageViewController: UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }

}

protocol TheoryPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(tutorialPageViewController: TheoryPageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(tutorialPageViewController: TheoryPageViewController,
                                    didUpdatePageIndex index: Int)

}
