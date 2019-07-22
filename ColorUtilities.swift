//
//  ColorUtilities.swift
//  scrum-ios
//
//  Created by Matias Glessi on 9/6/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit



enum GradientType {
    case quiz
    case random
    
}



struct Gradient {
    var topColor: UIColor
    var bottomColor: UIColor
}




class Colors {
    
    let allColors = [Gradient.init(topColor: UIColor(red:0.99, green:0.89, blue:0.52, alpha:1.0),
                                    bottomColor: UIColor(red:0.95, green:0.51, blue:0.51, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.09, green:0.92, blue:0.85, alpha:1.0),
                                    bottomColor: UIColor(red:0.38, green:0.47, blue:0.92, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.96, green:0.31, blue:0.64, alpha:1.0),
                                    bottomColor: UIColor(red:1.00, green:0.46, blue:0.46, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.38, green:0.15, blue:0.45, alpha:1.0)
                        , bottomColor: UIColor(red:0.77, green:0.20, blue:0.39, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.44, green:0.09, blue:0.92, alpha:1.0)
                        , bottomColor: UIColor(red:0.92, green:0.38, blue:0.38, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.26, green:0.90, blue:0.58, alpha:1.0),
                                    bottomColor: UIColor(red:0.23, green:0.70, blue:0.72, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.94, green:0.18, blue:0.76, alpha:1.0)
                        , bottomColor: UIColor(red:0.38, green:0.58, blue:0.92, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.09, green:0.68, blue:0.41, alpha:1.0)
                        , bottomColor: UIColor(red:0.34, green:0.79, blue:0.52, alpha:1.0)),
                      Gradient.init(topColor: UIColor(red:0.36, green:0.14, blue:0.48, alpha:1.0)
                        , bottomColor: UIColor(red:0.11, green:0.81, blue:0.87, alpha:1.0))
                    ]
    
    
    
    
    let gl: CAGradientLayer
    
    init() {
        let colorTop = UIColor(red:0.99, green:0.89, blue:0.52, alpha:1.0).cgColor
        let colorBottom = UIColor(red:0.95, green:0.51, blue:0.51, alpha:1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
    
    init(type: GradientType = .quiz) {
        switch type {
        case .random:
            
            let randomIndex = Int(arc4random_uniform(UInt32(allColors.count)))
            let randomColor = allColors[randomIndex]
            
            self.gl = CAGradientLayer()
            self.gl.colors = [randomColor.topColor.cgColor, randomColor.bottomColor.cgColor]
            self.gl.locations = [0.0, 1.0]
        default:
            let colorTop = UIColor(red:0.99, green:0.89, blue:0.52, alpha:1.0).cgColor
            let colorBottom = UIColor(red:0.95, green:0.51, blue:0.51, alpha:1.0).cgColor
            
            self.gl = CAGradientLayer()
            self.gl.colors = [colorTop, colorBottom]
            self.gl.locations = [0.0, 1.0]
        }
    }
}

