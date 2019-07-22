//
//  Content.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/6/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import UIKit
import youtube_ios_player_helper
import Kingfisher
import DLRadioButton
import SwiftyJSON

enum ContentType: String {
    
    case text = "text"
    case title = "title"
    case image = "image"
    case video = "video"
    case textAnswer = "textAnswer"
    case imageAnswer = "imageAnswer"
}


class Content: BaseModel {

    var type: ContentType = .text
    var data: String = ""
    var isCorrect: Bool?
    
    override init() {
        
    }
    
    init?(json: JSON) {
        super.init()
        self.type = ContentType.init(rawValue: json["type"].stringValue)!
        self.data = json["data"].stringValue
        
        switch self.type {
        case .imageAnswer, .textAnswer:
            self.isCorrect = json["isCorrect"].boolValue
        default:
            break
        }
        
    }

}


class VideoItemCell: UITableViewCell {
    
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var videoName: UILabel!
    
    
    var item: Content? {
        didSet {
            //            guard let item = item as? ContentVMVideoItem else { return }
            guard let item = item else { return }
            videoView.load(withVideoId: item.data)
        }
    }
}

class ImageItemCell: UITableViewCell {
    
    @IBOutlet weak var imageItemView: UIImageView!
    
    var item: Content? {
        didSet {
            guard let _ = item else { return }
            
            imageItemView.contentMode = .scaleAspectFit
            imageItemView.kf.indicatorType = .activity
        }
    }
}

class TitleItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var item: Content? {
        didSet {
            guard let item = item else { return }
            
            titleLabel.text = item.data
        }
    }
}

class TextItemCell: UITableViewCell {
    
    @IBOutlet weak var textContent: UITextView!
    
    var item: Content? {
        didSet {
            
            guard let item = item else { return }
            
            textContent.text = item.data
        }
    }
}


protocol AnswerSelectionDelegate {
    func selectedOption(answer: Content?)
}



class AnswerItemCell: UITableViewCell {
    
    var delegate: AnswerSelectionDelegate!

    @IBOutlet weak var controlContainerView: UIView!
    @IBOutlet var containerHeightConstraint: NSLayoutConstraint!
    private var buttons:[DLRadioButton] = [DLRadioButton]()

    
    var items: [Content]? {
        didSet {
            let controlHeight: CGFloat = 17
            let size: CGSize = CGSize(width: self.controlContainerView.frame.width,
                                      height: controlHeight)
            var offsetY: CGFloat = 0
            let initialY: CGFloat = 18
            var origin: CGPoint = CGPoint(x: 8.0, y: initialY )
            
            var lastSettedRadio: DLRadioButton?
            
            guard let items = items else { return }
            
            for item in items {
                
                
                let radio: DLRadioButton = DLRadioButton(frame: CGRect(origin: origin, size: size))
                let title: NSAttributedString = NSAttributedString.init(string: item.data, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
                radio.iconColor = UIColor.black
                radio.setAttributedTitle(title, for: .normal)
                radio.titleLabel?.numberOfLines = 0
                radio.titleLabel?.textAlignment = NSTextAlignment.left
                radio.setTitleColor(UIColor.black, for: .normal)
                radio.contentHorizontalAlignment = .left
                radio.marginWidth = 10
                
                radio.addTarget(self, action: #selector(tappedOption), for: .touchUpInside)
                
                
                if lastSettedRadio != nil {
                    
                    self.controlContainerView.insertSubview(radio, belowSubview: lastSettedRadio!)
                }
                else {
                    self.controlContainerView.addSubview(radio)
                    
                }
                
                lastSettedRadio = radio
                
                
                offsetY += 100
                
                origin = CGPoint(x: 8,
                                 y: offsetY + initialY)
                
                self.buttons.append(radio)
                
            }
            self.containerHeightConstraint.constant = CGFloat(100 * items.count)
        }
    }
   
    @objc func tappedOption(radioButton: DLRadioButton){
        self.buttons.forEach({ (button) in
            if (radioButton == button){
                radioButton.isSelected = !button.isSelected
            } else {
                button.isSelected = false
            }
        })
        radioButton.isSelected = true
        
        guard let items = items else { return }

        let answer = items.filter({
            $0.data == (radioButton.titleLabel?.text)!
        }).first
        
        self.delegate?.selectedOption(answer: answer)

    }
}



