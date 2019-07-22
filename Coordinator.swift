//
//  Coordinator.swift
//  scrum-ios
//
//  Created by Matias on 09/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    
    func childDidFinish(_ child: Coordinator?){
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
