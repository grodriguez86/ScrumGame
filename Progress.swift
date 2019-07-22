//
//  Progress.swift
//  scrum-ios
//
//  Created by Matias on 02/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

/*
 
 nivel id me dice de que nivel. si no existe progress para ese nivel no hay nada que mostrar (estado bloqueado/inicial)
 sublevel id me dice el actual sublevel de ese nivel (maixmo alcanzado). si es 0, es porque no se inicio. si es un numero es el current
 tuto completed me dice si completo o skipeo el nivel
 game me dice el numero de juego actual. si es 0 es que todavia no empezo a jugar (o no paso el 1ero, depende de los demas valores)
 
 */

class Progress: Object {
    
    @objc dynamic var level_id: Int = 0
    @objc dynamic var sublevel_id: Int = 0
    @objc dynamic var tutorial_completed: Bool = false
    @objc dynamic var actual_game: Int = 0
    @objc dynamic var total_games: Int = 0
    override static func primaryKey() -> String? {
        return "level_id"
    }
    
    func initFrom(json: JSON){
        self.level_id = json["level_number"].intValue
        self.sublevel_id = json["actual_sublevel"].intValue
        self.tutorial_completed = json["tutorial_completed"].boolValue
        self.actual_game = json["actual_game"].intValue
        self.total_games = json["total_games"].intValue
    }

    
}
