//
//  Storyboarded.swift
//  scrum-ios
//
//  Created by Matias on 09/03/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    
    static func instantiate(for sbName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(for sbName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: sbName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
