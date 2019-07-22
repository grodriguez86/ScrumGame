//
//  PPCardSelectedViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class PPCardSelectedViewController: UIViewController {

    @IBOutlet weak var cardValue: UILabel!
    @IBOutlet weak var backgroundCardImage: UIImageView!
    
    var valueSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cardValue.text = valueSelected
    }
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PPTableOfPlayersViewController {
            destination.myCardValue = valueSelected
        }
    }
    

}
