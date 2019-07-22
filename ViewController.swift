//
//  ViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 2/7/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         si no esta loggeado, ir a loggin. si no esta registrado, registrar.
         si esta logeado o se acaba de registrar, ir al home (que seria los niveles superiores)
         
         */
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        let messagesStoryboard = UIStoryboard.init(name: "Register", bundle: nil)
        let messagesVC = messagesStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController

        
        self.navigationController?.pushViewController(messagesVC, animated: true)
 
    }

    @IBAction func bigLevelsPressed(_ sender: Any) {
        
        
        let messagesStoryboard = UIStoryboard.init(name: "Levels", bundle: nil)
        let lalaVC = messagesStoryboard.instantiateViewController(withIdentifier: "LevelsViewController") as! LevelsViewController
        
        
        self.navigationController?.pushViewController(lalaVC, animated: true)

    }

    @IBAction func planningPokerPressed(_ sender: Any) {
        
        
        
//        let levelStoryboard = UIStoryboard.init(name: "Tutorial", bundle: nil)
//        let sublevelViewController = levelStoryboard.instantiateViewController(withIdentifier: "L1S1") as! L1S1ViewController
//        self.navigationController?.pushViewController(sublevelViewController, animated: true)
        

//        PopUpMessages.showCompletedMessage(with: "Excelente!", description: "Has completado exitosamente este nivel!", buttonMessage: "Continuar", messageType: .completion)
        
//        PopUpMessages.test()
        

////        return

        let ppStoryboard = UIStoryboard.init(name: "PlanningPoker", bundle: nil)
        let ppVC = ppStoryboard.instantiateViewController(withIdentifier: "PPIntroductionViewController") as! PPIntroductionViewController
        
        
        self.navigationController?.pushViewController(ppVC, animated: true)

        
        
    }
    
    
    
}



