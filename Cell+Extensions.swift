//
//  Cell+Extensions.swift
//  scrum-ios
//
//  Created by Matias Glessi on 9/5/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}


extension UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}



