//
//  SubLevelCollectionViewCell.swift
//  scrum-ios
//
//  Created by Matias Glessi on 3/22/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class SubLevelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sublevelTitleLabel: UILabel!
    @IBOutlet weak var sublevelStatusLabel: UILabel!

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var circularProgressView: MBCircularProgressBarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = 5
        self.backView.layer.masksToBounds = true

    }
    
    func setData(for sublevel: SubLevel, with progress: Progress?){
        self.sublevelTitleLabel.text = sublevel.name
        self.sublevelStatusLabel.text = sublevel.status
        if let progress = progress {
            self.circularProgressView.value = CGFloat(sublevel.percentage(from: progress))
        }
        else {
            self.circularProgressView.value = 0.0
        }
    }
    
}
