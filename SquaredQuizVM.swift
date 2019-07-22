//
//  SquaredQuizVM.swift
//  scrum-ios
//
//  Created by Matias Glessi on 9/5/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SquaredQuizVM: BaseVM, AnswerSelectionDelegate {
    
    typealias OptionSelectedBlock = (_: Content)-> Void
    
    var optionBlock: OptionSelectedBlock?
    var items = [Content]()
    var question = Content.init()
    
    
    func getContentFor(game: Game) {
        
//        switch game.gameType {
//        case .textQuiz, .imageQuiz:
//
//            if let first = game.content.first {
//                question = first
//                game.content.removeFirst()
//            }
//
//        default:
//            return
//        }
        
        items = game.content
        
//        for item in game.content {
//            if let item = item as? Content {
//                items = item.answers
//            }
//        }
        
        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: self.items)
        
        
    }
    
    func selectedOption(answer: Content?) {
        if let ans = answer {
            self.optionBlock?(ans)
        }
    }
    
}

extension SquaredQuizVM: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let item = items[indexPath.row]
        
        switch item.type {
            
        case .imageAnswer:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizImageCell.identifier, for: indexPath) as? QuizImageCell {
                cell.item = item
                cell.delegate = self
                return cell
            }

        case .textAnswer:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizTextCell.identifier, for: indexPath) as? QuizTextCell {
                cell.item = item
                cell.delegate = self
                return cell
            }
        default:
            break
        }
        
        
        return UICollectionViewCell()

    }
    


}

extension SquaredQuizVM: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells: CGFloat = 2
        let cellWidth = (UIScreen.main.bounds.size.width - (3*10.0)) / numberOfCells
        return CGSize.init(width: cellWidth, height: cellWidth)
        
    }
    
}

extension SquaredQuizVM: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        let item = items[indexPath.row]

        switch item.type {
        
        case .imageAnswer:
            
            if let url = URL(string: item.data) {
                
                _ = (cell as! QuizImageCell).imageView.kf.setImage(with: url,
                                                                       placeholder: nil,
                                                                       options: [.transition(ImageTransition.fade(1))],
                                                                       progressBlock: { receivedSize, totalSize in  },
                                                                       completionHandler: { image, error, cacheType, imageURL in
                })
            }

        
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        switch item.type {
        case .imageAnswer:
            (cell as! QuizImageCell).imageView.kf.cancelDownloadTask()
        default:
            break
        }

        
    }
    
    
}

