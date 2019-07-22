//
//  DraggableView.swift
//  scrum-ios
//
//  Created by Matias Glessi on 5/27/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import UIKit
import EasyTipView

class DraggableView: UIImageView{
    
    
    weak var 	draggableContainerDelegate: DraggableViewDelegate?

    var lastLocation: CGPoint = CGPoint.init()
    
    let bool = false
    
    var popTipText = ""
//    var direction: PopTipDirection = .down
    
    var originalLocation: CGPoint = CGPoint.init()
    var finalLocation: CGPoint = CGPoint.init()
//    var popTip = PopTip()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let panRecognizer = UIPanGestureRecognizer.init(target: self, action:#selector(self.detectPan(recognizer:)))
        self.gestureRecognizers = [panRecognizer]
        self.isUserInteractionEnabled = true
        self.originalLocation = frame.origin
        print(frame.origin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setFinalLocation(point: CGPoint){
        self.finalLocation = point
    }
    
    func setTooltip(with text: String){

        self.popTipText = text
        
    }
    
    @objc func detectPan(recognizer: UIPanGestureRecognizer){
        self.draggableContainerDelegate?.dismissOldToolTipIfPresent()
        let translation = recognizer.translation(in: self.superview)
        self.center = CGPoint.init(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
//        print(self.center)
        if recognizer.state == .ended {
            if (!self.isNearTarget(center: self.center)){
                self.frame.origin = self.originalLocation

//                print(originalLocation)
            }
            else {
                self.draggableContainerDelegate?.setted(view: self)
//                self.draggableContainerDelegate?.viewSetted()
                self.center = finalLocation
                self.isUserInteractionEnabled = false
                
//                self.popTip.show(text: popTipText, direction: direction, maxWidth: 200, in: self.superview!, from: self.frame)
//                self.popTip.show(text: popTipText, direction: direction, maxin: self.superview!, from: self, duration: 200)
                
                
//                self.popTip.show(text: popTipText, direction: .down, maxWidth: 260, in: self, from: CGRect.init(origin: finalLocation, size: CGSize.init(width: 250, height: 250)))
            }
        }

    }
    
    func isNearTarget(center: CGPoint) -> Bool{
        
        if self.finalLocation.x - 20 ... self.finalLocation.x + 20 ~= center.x {
            if self.finalLocation.y - 20 ... self.finalLocation.y + 20 ~= center.y {
                
                return true
            }
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
        self.lastLocation = self.center
        
        // Remember original location
        lastLocation = self.center;
    }


}
