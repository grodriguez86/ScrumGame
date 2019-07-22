//
//  PPConfrontationViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class PPConfrontationViewController: UIViewController {

    @IBOutlet weak var player3cardImage: UIImageView!
    @IBOutlet weak var player3cardValue: UILabel!
    @IBOutlet weak var myCardImage: UIImageView!
    @IBOutlet weak var myCardValue: UILabel!
    
    
    var myCardStringValue = ""
    var player3CardStringValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        player3cardValue.text = player3CardStringValue
        myCardValue.text = myCardStringValue
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PPCardSelectionViewController {
            
            destination.selectionType = .secondRound
        }
    }

}
