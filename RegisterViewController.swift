//
//  RegisterViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 3/14/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {

    var manSelected = true
    
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var womanGenreButton: UIButton!
    @IBOutlet weak var manGenreButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func womanButtonTapped(_ sender: Any) {
        if(manSelected)
        {
            womanGenreButton.backgroundColor = UIColor(red:0.09, green:0.56, blue:0.18, alpha:1.0)
            womanGenreButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            manGenreButton.backgroundColor = UIColor.white
            manGenreButton.setTitleColor(UIColor(red:0.09, green:0.56, blue:0.18, alpha:1.0), for: UIControlState.normal)
            manSelected = false

        }
    }

    @IBAction func manButtonTapped(_ sender: Any) {
        if(!manSelected)
        {
            manGenreButton.backgroundColor = UIColor(red:0.09, green:0.56, blue:0.18, alpha:1.0)
            manGenreButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            womanGenreButton.backgroundColor = UIColor.white
            womanGenreButton.setTitleColor(UIColor(red:0.09, green:0.56, blue:0.18, alpha:1.0), for: UIControlState.normal)
            manSelected = true
        }
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
