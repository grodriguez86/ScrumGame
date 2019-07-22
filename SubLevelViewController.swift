//
//  SubLevelViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 3/25/17.
//  Copyright © 2017 Matias Glessi. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import Bartinter

class SubLevelViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, BaseVMDelegate, Storyboarded {
    
    weak var coordinator: LevelsCoordinator?
    
    @IBOutlet weak var levelTitle: UILabel!
    @IBOutlet weak var subLevelsTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var progress: Progress?
   
    
    var sublevelCompletedInfo: SublevelCompletedInfo?
    var cellSize: CGSize = CGSize.init()
    var viewModel = SubLevelVM()
    var currentLevel: Level?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatesStatusBarAppearanceAutomatically = true
        self.viewModel.delegate = self

        self.collectionView.register(UINib(nibName: "SubLevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubLevelCell")
        
        setCellSize()
        
        let layout = UPCarouselFlowLayout()
        /*
        let scaledHeight = collectionView.frame.height
        let scaledWidth = UIScreen.main.bounds.size.width * (455/UIScreen.main.bounds.size.height)
         */

        layout.itemSize = CGSize.init(width: 250, height: 400)

        
        //layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 30, height: collectionView.frame.height)
        
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let current = currentLevel {
            self.viewModel.getSubLevels(for: current)
            self.levelTitle.text = current.title
            
            
        }
    }

    func updateUI(){
        if let current = currentLevel {
            self.subLevelsTitle.text = self.viewModel.getDescription()
            if let levelId = current.id {
                self.progress = self.viewModel.progressFor(level: levelId)
            }
        }
    }
    
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let sublevelInfo = sublevelCompletedInfo {
            let indexPath = IndexPath.init(row: sublevelInfo.sublevelNumber, section: 0)
//            self.viewModel.sublevels[indexPath.row].percentage = sublevelInfo.newPercentage
            
            collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: [indexPath])
            }, completion: nil)
            
            sublevelCompletedInfo = nil
        }

    }
    
    
    func setCellSize()
    {
        let scaledWidth = UIScreen.main.bounds.size.width * (455/UIScreen.main.bounds.size.height)
        self.cellSize = CGSize(width: 455, height: 455)
    }
    

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt sizeForItemAtIndexPath: IndexPath) -> CGSize {
        
        return cellSize;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.totalSubLevels
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let current = currentLevel {
            coordinator?.openSublevel(level: current, sublevel: self.viewModel.sublevels[indexPath.row])

        }
        
        
        
//        let levelStoryboard = UIStoryboard.init(name: "Tutorial", bundle: nil)
//        let sublevelViewController = levelStoryboard.instantiateViewController(withIdentifier: "SubLevelLogicViewController") as! SubLevelLogicViewController
//
//        sublevelViewController.sublevel = self.viewModel.sublevels[indexPath.row]
//        self.navigationController?.pushViewController(sublevelViewController, animated: true)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubLevelCell", for: indexPath) as! SubLevelCollectionViewCell
        cell.setData(for: self.viewModel.sublevels[indexPath.row], with: progress)
        return cell
    }


    @IBAction func backButtonTapped(_ sender: Any) {
        self.coordinator?.back()
    }

    func chooseOnboardForLevel1(index: IndexPath){
        
        let sublevel = index.row + 1
        
        switch sublevel {
        
        case 1:
            let levelStoryboard = UIStoryboard.init(name: "Level1", bundle: nil)
            let sublevelViewController = levelStoryboard.instantiateViewController(withIdentifier: "L1S1") as! L1S1ViewController
            self.navigationController?.pushViewController(sublevelViewController, animated: true)

        default:
            break
        }
    }
    
    func didFinishTask(sender: BaseVM, errorMessage: String?, dataArray: [NSObject]?) {
        self.updateUI()
        self.collectionView.reloadData()
        
    }
    

}
