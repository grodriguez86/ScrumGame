//
//  PPExplanationViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class PPExplanationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? PPCardSelectionViewController {
            
            destination.selectionType = .firstOne
        }
    }

}
