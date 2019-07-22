//
//  PPConclusionViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class PPConclusionViewController: UIViewController {

    @IBOutlet weak var conclusionCardBackground: UIImageView!
    @IBOutlet weak var conclusionCardValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        conclusionCardValue.text = "8"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endPP(_ sender: Any) {
        
        
        
        
    }
    

}
