//
//  ContentVM.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/8/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ContentVM: BaseVM, AnswerSelectionDelegate {
    
    typealias OptionSelectedBlock = (_: Content)-> Void

    var optionBlock: OptionSelectedBlock?
    var items = [Content]()
    var steps = [BaseModel]()
    var quizVM = false
    
    
    func getContentFor(game: Game) {
        
        
        for item in game.content {
            items.append(item)
        }
        
        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: self.items)

        
    }
    
    
    func getContent(for step: Step) {
        
        
        
        for item in step.content {
            items.append(item)
        }
        
        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: self.items)
        
    }
    
    func selectedOption(answer: Content?) {
        if let ans = answer {
            self.optionBlock?(ans)
        }
    }

}

extension ContentVM: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if quizVM { return 1 }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let item = step[stepPage].items[indexPath.row]

        let item = items[indexPath.row]
        
        switch item.type {
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextItemCell.identifier, for: indexPath) as? TextItemCell {
                cell.item = item
                return cell
            }

        case .title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleItemCell.identifier, for: indexPath) as? TitleItemCell {
                cell.item = item
                return cell
            }

        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ImageItemCell.identifier, for: indexPath) as? ImageItemCell {
                cell.item = item
                return cell
            }

        case .video:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VideoItemCell.identifier, for: indexPath) as? VideoItemCell {
                cell.item = item
                return cell
            }
    
        case .textAnswer, .imageAnswer:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnswerItemCell.identifier, for: indexPath) as? AnswerItemCell {
//                cell.item = item
                cell.items = items
                cell.delegate = self
                return cell
            }
        }

        
        return UITableViewCell()
    }
    
    
    
}

extension ContentVM: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        // let item = step[stepPage].items[indexPath.row]

        let item = items[indexPath.row]

        switch item.type {
        case .video:
            return 150.0
        case .image:
            // TODO: REVIEW
            return 250.0
//        case .answer:
//            // TODO: REVIEW
//            return 100.0

        default:
            break
        }
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        if (tableView.cellForRow(at: indexPath) as? AnswerItemCell) != nil {
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // let item = step[stepPage].items[indexPath.row]

        let item = items[indexPath.row]

        switch item.type {
        case .image:
            
//            if let item = item {
                if let url = URL(string: item.data) {
                    
                    _ = (cell as! ImageItemCell).imageItemView.kf.setImage(with: url,
                                                                                     placeholder: nil,
                                                                                     options: [.transition(ImageTransition.fade(1))],
                                                                                     progressBlock: { receivedSize, totalSize in  },
                                                                                     completionHandler: { image, error, cacheType, imageURL in
                    })
                }

//            }
            
        default:
            break
        }
        
        

    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // let item = step[stepPage].items[indexPath.row]

        let item = items[indexPath.row]
        
        switch item.type {
        case .image:
            (cell as! ImageItemCell).imageItemView.kf.cancelDownloadTask()
        default:
            break
        }

    }
    
}
