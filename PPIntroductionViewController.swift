//
//  PPIntroductionViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class PPIntroductionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundLayer = Colors.init(type: .quiz).gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
