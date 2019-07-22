//
//  SquaredQuizGameViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 9/5/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class SquaredQuizGameViewController: UIViewController, BaseVMDelegate {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = SquaredQuizVM()
    var game: Game?
    weak var gameDelegate: GameManagerDelegate?
    var correctAnswerSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        collectionView?.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.register(QuizTextCell.nib, forCellWithReuseIdentifier: QuizTextCell.identifier)
        collectionView.register(QuizImageCell.nib, forCellWithReuseIdentifier: QuizImageCell.identifier)

        if let parentVC = self.parent as? GameViewController {

            if let currentGame = parentVC.games.first {

                self.game = currentGame

                self.viewModel.getContentFor(game: currentGame)
                self.questionTextView.text = game?.title
            }

        }

        if let dataSource = self.collectionView.dataSource as? SquaredQuizVM {
            dataSource.optionBlock = { [weak self] (answerSelected) in
                guard let strongSelf = self else { return }
                guard let result = answerSelected.isCorrect else { return }
                
                strongSelf.correctAnswerSelected = result
            }
        }
    }
    
    @IBAction func answerQuiz(_ sender: Any) {
        
        
        if correctAnswerSelected {
            
            let alertController = UIAlertController(title: "Excelente!", message: "La respuesta es correcta 🤓", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
                alert -> Void in
                self.gameDelegate?.prepareForNextGame()
            })
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            let alertController = UIAlertController(title: "Incorrecto!", message: "La respuesta es incorrecta 💩 Inténtalo de nuevo!", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction.init(title: "Aceptar", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    
    func didFinishTask(sender: BaseVM, errorMessage: String?, dataArray: [NSObject]?) {
        self.questionTextView.text = self.viewModel.question.data
        self.collectionView.reloadData()

    }

}


import Kingfisher

class QuizTextCell: UICollectionViewCell {
    
    @IBOutlet weak var selectorOutsideView: UIView!
    @IBOutlet weak var selectorInsideView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var delegate: AnswerSelectionDelegate!

    
    
    var item: Content? {
        didSet {
            
            guard let item = item else { return }
            
            textLabel.text = item.data
            textLabel.textColor = UIColor.white
        }
    }
    
    override func awakeFromNib() {
        selectorInsideView.makeCircular()
        selectorOutsideView.makeCircular()
        selectorInsideView.hide()
        backView.backgroundColor = UIColor.clear
        let backgroundLayer = Colors.init(type: .random).gl
        backgroundLayer.frame = backView.frame
        backView.layer.insertSublayer(backgroundLayer, at: 0)
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true

    
    }
    
    
    override var isSelected: Bool {
        
        didSet {
            if self.isSelected {
                self.backView.setBorder(width: 1, color: UIColor.darkGray.cgColor)
                self.selectorInsideView.show()
                self.delegate?.selectedOption(answer: self.item)

            }
            else {
                self.backView.setBorder(width: 0)
                self.selectorInsideView.hide()
            }
        }
        
    }
    
}


class QuizImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    var delegate: AnswerSelectionDelegate!

    
    var item: Content? {
        didSet {
            
            guard let _ = item else { return }
            
            imageView.contentMode = .scaleAspectFit
            imageView.kf.indicatorType = .activity
            
            // TODO: Set possible image?
        }
    }
}



