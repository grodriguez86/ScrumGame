//
//  PPTableOfPlayersViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class PPTableOfPlayersViewController: UIViewController {

    @IBOutlet weak var myCardImage: UIImageView!
    @IBOutlet weak var myCardLabel: UILabel!
    @IBOutlet weak var player1CardImage: UIImageView!
    @IBOutlet weak var player1CardLabel: UILabel!
    @IBOutlet weak var player2CardImage: UIImageView!
    @IBOutlet weak var player2CardLabel: UILabel!
    @IBOutlet weak var player3CardImage: UIImageView!
    @IBOutlet weak var player3CardLabel: UILabel!
    
    var myCardValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myCardLabel.text = myCardValue
        self.generatePlayersValues()
        self.setCardsUI()
    }
    
    private func generatePlayersValues(){
        
//        let fibonacciSequence = ["0", "1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100", "∞", "?"]
        
        switch myCardValue {
        case "0", "1/2", "1", "2", "3", "5", "8":
            self.player1CardLabel.text = "13"
            self.player2CardLabel.text = "20"
            self.player3CardLabel.text = "40"
        case "13", "20", "40", "100":
            self.player1CardLabel.text = "5"
            self.player2CardLabel.text = "5"
            self.player3CardLabel.text = "1"
        default:
            break
        }
    }
    
    private func setCardsUI(){
        self.setGradientBackground(to: myCardImage)
        self.setGradientBackground(to: player1CardImage)
        self.setGradientBackground(to: player2CardImage)
        self.setGradientBackground(to: player3CardImage)
    }
    
    private func setGradientBackground(to view: UIView) {
        let backgroundLayer = Colors().gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PPConfrontationViewController {
            
            destination.myCardStringValue = myCardValue
            destination.player3CardStringValue = player3CardLabel.text!
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
