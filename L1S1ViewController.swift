//
//  L1S1ViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 4/22/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import UIKit
//import BWWalkthrough
import EasyTipView
import Bartinter
import SwiftEntryKit

class L1S1ViewController: UIViewController, DraggableViewDelegate, EasyTipViewDelegate {

    
    weak var gameDelegate: GameManagerDelegate?
    
    @IBOutlet weak var elementsContainerView: UIView!
    @IBOutlet weak var scrumFlowView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    
    var viewsSetted: Int = 0
    var presentedToolTip: EasyTipView?

    override func viewDidLoad() {
        super.viewDidLoad()
        updatesStatusBarAppearanceAutomatically = true
        let flowHeight =  self.scrumFlowView.bounds.height
        
        print("BOUNDS")
        print(scrumFlowView.bounds)
        
        var x: CGFloat = 40.0
        
        let incrementDG = DraggableView.init(frame: CGRect.init(x: x, y: flowHeight + 50, width: 65, height: 105))
        incrementDG.image = UIImage.init(named: "L1_shipIncrement")
        incrementDG.draggableContainerDelegate = self
        incrementDG.setTooltip(with: "Bien ahi! El producto incrementable es lo que se puede entregar al final de cada iteracion.")
        self.containerView.addSubview(incrementDG)
        
        incrementDG.setFinalLocation(point: ConstantsHelper.getShippingIncrementOriginalPoint())
        
        x = x + incrementDG.bounds.width + CGFloat(40.0)
        
        let productBacklogDG = DraggableView.init(frame: CGRect.init(x: x , y: flowHeight + 50, width: 47, height: 75))
        productBacklogDG.image = UIImage.init(named: "L1_prodBacklog")
        productBacklogDG.draggableContainerDelegate = self
        productBacklogDG.setTooltip(with: "Excelente! El Product Backlog es el lugar donde figuran todas las tareas que el producto requiere desarrollar.")

        self.containerView.addSubview(productBacklogDG)
        
        productBacklogDG.setFinalLocation(point: ConstantsHelper.getProductBacklogOriginalPoint())
        
        x = x + productBacklogDG.bounds.width + CGFloat(40.0)
        
        let sprintBacklogDG = DraggableView.init(frame: CGRect.init(x: x, y: flowHeight + 50, width: 47, height: 75))
        sprintBacklogDG.image = UIImage.init(named: "L1_sprintBacklog")
        sprintBacklogDG.draggableContainerDelegate = self
        sprintBacklogDG.setTooltip(with: "Perfecto! El Sprint Backlog es el lugar donde figuran todas las tareas que el equipo decidió que realizaran en esta iteracion.")

        self.containerView.addSubview(sprintBacklogDG)
                
        sprintBacklogDG.setFinalLocation(point: ConstantsHelper.getSprintBacklogOriginalPoint())
 
        let dailyDG = DraggableView.init(frame: CGRect.init(x: 50, y: flowHeight + 50 + incrementDG.bounds.height + 20, width: 108.5, height: 25))
        dailyDG.image = UIImage.init(named: "L1_daily")
        dailyDG.draggableContainerDelegate = self
        dailyDG.setTooltip(with: "Genial! La Daily Scrum Meeting es la reunion diaria donde se sincroniza el equipo sobre el estado de cada uno de sus miembros. Aprenderás sobre ella más adelante! 😊")

        self.containerView.addSubview(dailyDG)
        
        dailyDG.setFinalLocation(point: ConstantsHelper.getDailyOriginalPoint())
        
        let sprintDG = DraggableView.init(frame: CGRect.init(x: 50 + dailyDG.bounds.width + 20, y: flowHeight + 50 + incrementDG.bounds.height, width: 53.5, height: 57.5))
        sprintDG.image = UIImage.init(named: "L1_sprint")
        sprintDG.draggableContainerDelegate = self
        sprintDG.setTooltip(with: "Buenisimo! El Sprint es la iteracion en si. Esta puede durar de 2 a 4 semanas y es el tiempo en el que el equipo desarrolla las tareas que definio en el Sprint Backlog.")

        self.containerView.addSubview(sprintDG)

        sprintDG.setFinalLocation(point: ConstantsHelper.getSprintOriginalPoint())
    
//    }
        

        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top

        EasyTipView.globalPreferences = preferences

    
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(containerViewTap))
        self.view.addGestureRecognizer(tap)
//        self.containerView.addGestureRecognizer(tap)
//        self.scrumFlowView.addGestureRecognizer(tap)

    }



    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    

    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        
        if let _  = self.presentedToolTip {
            viewsSetted = viewsSetted + 1
            print("dismissing by hand! +1")
            self.presentedToolTip = nil
            checkIfAllSetted()
        }
    }


    @objc func containerViewTap(){
        self.dismissOldToolTipIfPresent()
    }


    func dismissOldToolTipIfPresent() {

        if let toolTip = self.presentedToolTip {
            toolTip.dismiss()
            viewsSetted = viewsSetted + 1
            print("dismissing by drag or container tap! +1")
            self.presentedToolTip = nil
            checkIfAllSetted()
        }
    }
    


    func setted(view: UIView) {
        
        if let dView = view as? DraggableView {
//
//            if let tooltip = self.presentedToolTip {
//                toolTip.dismiss()
//                viewsSetted = viewsSetted + 1
//                print("dismissing by otherToolt! +1")
//            }
            
            self.presentedToolTip = EasyTipView.init(text: dView.popTipText, delegate: self)
            self.presentedToolTip?.show(forView: view)
            
            print("Views setted? \(viewsSetted)")
        }
    }
    
    
    func checkIfAllSetted(){
        
        print("checking if views are 5")
        
        if viewsSetted == 5 {
            
            PopUpMessages.showCompletedTaskWithCompletion(with: "Completo", description: "Completo", buttonMessage: "Completo", messageType: .taskCompleted, dismissAction: {
                self.gameDelegate?.prepareForNextGame()
            })
            
        }
    }
}

protocol DraggableViewDelegate: class {
    
    func setted(view: UIView)
    func dismissOldToolTipIfPresent()
}

