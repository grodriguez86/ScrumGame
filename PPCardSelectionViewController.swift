//
//  PPCardSelectionViewController.swift
//  scrum-ios
//
//  Created by Intermedia on 11/11/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit


enum SelectionType {
    
    case firstOne
    case secondRound
}

class PPCardSelectionViewController: UIViewController {

    let fibonacciSequence = ["0", "1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100", "∞", "?"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectionType: SelectionType = .firstOne
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension PPCardSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ppStoryboard = UIStoryboard.init(name: "PlanningPoker", bundle: nil)

        
        let value = fibonacciSequence[indexPath.row]
        
        if value == "∞" || value == "?" {
            
            PopUpMessages.showCompletedTaskWithCompletion(with: "Elegiste la carta ?", description: "Esta carta es una mierda, slds", buttonMessage: "OK", messageType: .completionWithAction, dismissAction: {
                
                print("okasa")
            })
            
            
            return
        }
        
        
        
        
        switch selectionType {

        case .firstOne:
            let cardSelectedVC = ppStoryboard.instantiateViewController(withIdentifier: "PPCardSelectedViewController") as! PPCardSelectedViewController
            
            cardSelectedVC.valueSelected = fibonacciSequence[indexPath.row]
            self.navigationController?.pushViewController(cardSelectedVC, animated: true)

        case .secondRound:
            
            let cardSelectedVC = ppStoryboard.instantiateViewController(withIdentifier: "PPConclusionViewController") as! PPConclusionViewController
            
//            cardSelectedVC.valueSelected = fibonacciSequence[indexPath.row]
            self.navigationController?.pushViewController(cardSelectedVC, animated: true)
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PPCardCollectionCell", for: indexPath) as! PPCardCollectionCell
        
        cell.valueLabel.text = fibonacciSequence[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fibonacciSequence.count
    }
}

class PPCardCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
}


