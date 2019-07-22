//
//  SublevelVM.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/7/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation
import RealmSwift

class SubLevelVM: BaseVM {
    
    var sublevels: [SubLevel] = []
    var progresses: [Progress] = []

    
    var totalSubLevels: Int {
        return sublevels.count
    }
    
    
    func getSubLevels(for level: Level) {
        
        SystemLevelsService.getSublevels(for: level) { (sublevels, error) in
            if let error = error {
                print(error)
            }
            else {
                self.sublevels = sublevels
                self.progresses = self.getProgresses()
                self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: [])
                
            }

        }
    }
    
    func getProgresses() -> [Progress] {
        let realm = try! Realm()
        let objects = realm.objects(Progress.self).toArray(ofType: Progress.self) as [Progress]
        return objects.count > 0 ? objects : []
    }

    
    func progressFor(level: Int) -> Progress? {
        
        if !(progresses.count > 0) { return nil }
        
        if level > progresses.count - 1 { return nil }
        
        return progresses[level]
        
    }
    
    func getDescription() -> String {
        
        switch totalSubLevels {
        case 0:
            return "--"
        case 1:
            return "\(totalSubLevels) subnivel"
        default:
            return "\(totalSubLevels) subniveles"
        }
    }


    
    func getAllSublevels(for level: Level) {
        
        // Should be a service call
        let sl0 = SubLevel.init()
        sl0.name = "Repaso"
        sl0.percentage = 100
        
        // Should be a service call
        let sl1 = SubLevel.init()
        sl1.name = "Introducción"
        sl1.percentage = 25
        
        
        let sl2 = SubLevel.init()
        sl2.name = "Intermedio"
        sl2.percentage = 0
        
        self.sublevels = level.sublevels
        
        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: sublevels)
        
    }
    
    
    func getStepsForSublevel(){
        
        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: nil)
        
    }
    func getGamesForSublevel(){
        
        
        
        
    }
    
    
    
//    func fetchGamesFor(sublevel: SubLevel) {
//        
//        
//        // LOS OBTENGO DEL SERVICE
//        
//        var dictonaryGames: [[String : Any]] = []
//        
//        let answersTextQuiz = [
//            ["answer": "Product Owner",
//             "isCorrect": false,
//             "type": "text"
//            ],
//            
//            ["answer": "Scrum Master",
//             "isCorrect": false,
//             "type": "text"
//            ],
//            
//            ["answer": "Ninguno",
//             "isCorrect": true,
//             "type": "text"
//            ],
//            
//            ["answer": "Ambos",
//             "isCorrect": false,
//             "type": "text"
//            ]
//
//            
//        ]
//
//        
//        let answers = [
//            ["answer": "Si, es una posibilidad.",
//             "isCorrect": false,
//             "type": "text"
//                
//            ],
//            
//            ["answer": "No! Generaria un problema problema problema. Vos tenes que llevarlo al lugar mas reconidto de tu casa, y cagarlo a tiros. Sos inimputable hermano.",
//             "isCorrect": true,
//             "type": "text"
//            ],
//
//            ["answer": "Ambas son correctas.",
//             "isCorrect": false,
//             "type": "text"
//            ]
//
//        ]
//        
//        let itemsGameTextQuiz =  [
//            ["type": "text",
//             "data": "¿Quien es el encargado de dar las ordenes en el equipo?"],
//            
//            ["type": "answer",
//             "data": answersTextQuiz]
//        
//        ]
//        
//        let itemsGame = [
//            ["type": "text",
//             "data": "Que crees que se deba hacer? Es una pregunta un poco larga, pero creo que podras responderla facilmente con una de estas dos opciones. Recuerda que No significa Si y Si significa No. Es obvio eso. En realidad no. Es todo relativo maldita zea."],
//            
//            ["type": "answer",
//             "data": answers],
//            
//            ]
//        
//        let game1: [String : Any] = [
//            "gameType": "quiz",
//            "items": itemsGame
//        ]
//        
//        let game2: [String : Any] = [
//            "gameType": "draggable",
//            "code": "1.1.2"
//        ]
//
//        let game3: [String : Any] = [
//            "gameType": "textQuiz",
//            "items": itemsGameTextQuiz
//        ]
//        
//        dictonaryGames.append(game3)
//        dictonaryGames.append(game2)
//        dictonaryGames.append(game1)
//        
//        
//        // LOS PARSEO Y LOS DEVUELVO
//        
//        
//        var parsedGames: [Game] = []
//        
//        for game in dictonaryGames {
//            
//            let newGame: Game = Game()
//            
//            if let gameType = game["gameType"] as? String {
//                
//                switch gameType {
//                    
//                case "draggable":
//                    newGame.gameType = GameType.draggable
//                case "quiz":
//                    newGame.gameType = GameType.quiz
//                case "textQuiz":
//                    newGame.gameType = GameType.textQuiz
//
//                default:
//                    break
//                }
//            }
//            
//            if let code = game["code"] as? String {
//                newGame.code = code
//            }
//            
//            if let items = game["items"] as? [[String : Any]] {
//                
//                for item in items {
//                    
//                    var newItem = Content.init()
//                    
//                    if let type = item["type"] as? String {
//                        
//                        switch type {
//                        case "text":
//                            newItem.type = ContentType.text
//                        case "title":
//                            newItem.type = ContentType.title
//                        case "image":
//                            newItem.type = ContentType.image
//                        case "video":
//                            newItem.type = ContentType.video
//                        case "answer":
//                            newItem = ContentVMItemAnswer.init()
//                            newItem.type = ContentType.answer
//                        default:
//                            break
//                        }
//                        
//                        if let data = item["data"] as? String {
//                            newItem.data = data
//                        }
//                        
//                        
//                        if let jsonAnswers = item["data"] as? [[String : Any]] {
//                            // son respuestas, newItem es del tipo respuestas
//                            var fetchedAnswers: [Answer] = []
//                            
//                            if let newItem = newItem as? ContentVMItemAnswer {
//                                
//                                
//                                for jsonAns in jsonAnswers {
//                                    
//                                    var answer = Answer.init()
//                                    
////                                    var isCorrect = false
////                                    var string = ""
////                                    var answerType = AnswerType.imageAnswer
//                                    
//                                    if let valid = jsonAns["answer"] as? String {
////                                        string = valid
//                                        answer.answer = valid
//                                    }
//                                    if let valid = jsonAns["isCorrect"] as? Bool {
////                                        isCorrect = valid
//                                        answer.isCorrect = valid
//
//                                    }
//                                    
//                                    if let valid = jsonAns["type"] as? String {
//                                        
//
//                                        switch valid {
//                                        case "text":
////                                            answerType = AnswerType.textAnswer
//                                            answer.type = AnswerType.textAnswer
//
//                                        case "image":
////                                            answerType = AnswerType.imageAnswer
//                                            answer.type = AnswerType.imageAnswer
//
//                                        default:
////                                            answerType = AnswerType.textAnswer
//                                            answer.type = AnswerType.textAnswer
//
//                                        }
//                                    }
//                                    
//                                    fetchedAnswers.append(answer)
//                                    
////                                    fetchedAnswers.append(Answer.init(answer: string, isCorrect: isCorrect, type: answerType))
//                                }
//                                
//                                
//                                newItem.answers = fetchedAnswers
//                                
//                                
//                            }
//                            
//                            
//                            
//                        }
//                        
//                        
//                        
//                        newGame.content.append(newItem)
//                    }
//                    
//                    
//                }
//                
//            }
//            
//            parsedGames.append(newGame)
//            
//        }
//        
//        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: parsedGames)
//        
//        
//        
//    }
    
    
//    func fetchStepsFor(sublevel: SubLevel){
//        
//        
//        
//        // LOS OBTENGO DEL SERVICE
//        
//        var steps: [[[String : Any]]] = []
//        
//        let items = [
//            ["type": "title",
//             "data": "Este es un titulo!"],
//
//            ["type": "video",
//             "data": "jUz1ytcnn3c"],
//
//            ["type": "image",
//             "data": "https://www.interbel.es/wp-content/uploads/2015/10/Simple-kanban-board-.jpg"],
//
//            ["type": "text",
//             "data": "Este es un parrafo. Puede utilizarse para describir alguna situacion mas compleja o algun texto explicativo. Puede tener el largo necesario."]
//        ]
//        
//        let items2 = [
//            ["type": "text",
//             "data": "Esta es la segunda pagina del tutorial, y la ultima! Ahora la  flecha de avanzar se transforma en algo que lleve a jugar 😊"],
//            ]
//        
//        steps.append(items)
//        steps.append(items2)
//        
//        //       steps tiene dos steps. el primero tiene un arreglo de 2 items. el segundo tiene un arreglo de 1 item
//        //      item: [String : Any] ---- items: [[String : Any]]. steps: [ [[String : Any]]]
//        
//        //        var parsedSteps: [Step] = []
//        
//        var parsedSteps: [Step] = []
//        
//        // LOS PARSEO Y LOS DEVUELVO
//        for step in steps {
//            
//            //            var step: Step = Step.init(code: "")
//            let singleStep = Step.init()
//            
//            for item in step {
//                
//                let newItem = Content.init()
//                
//                if let type = item["type"] as? String {
//                    
//                    
//                    if let data = item["data"] as? String {
//                        newItem.data = data
//                    }
//                    
//                    switch type {
//                        
//                    case "text":
//                        newItem.type = ContentType.text
//                    case "title":
//                        newItem.type = ContentType.title
//                    case "image":
//                        newItem.type = ContentType.image
//                    case "video":
//                        newItem.type = ContentType.video
//                    case "answer":
//                        newItem.type = ContentType.answer
//                    default:
//                        break
//                    }
//                    
//                    singleStep.content.append(newItem)
//                }
//            }
//            
//            parsedSteps.append(singleStep)
//        }
//        
//        self.delegate?.didFinishTask(sender: self, errorMessage: nil, dataArray: parsedSteps)
//    }
    
}

