//
//  Step.swift
//  scrum-ios
//
//  Created by Matias on 02/04/2019.
//  Copyright © 2019 Matias Glessi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Step: BaseModel {
    
    var content: [Content] = []
    var code: String = ""
    
    override init() {}
    
    
    init?(json: JSON) {
        super.init()
        self.code = json["code"].stringValue
        self.content = json["content"].arrayValue.compactMap { Content(json: $0) }
    }
    
    
}
