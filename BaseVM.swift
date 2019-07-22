//
//  BaseVM.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/6/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import Foundation

class BaseVM: NSObject {
    
    weak var delegate: BaseVMDelegate?
}

protocol BaseVMDelegate: class {
    
    func didFinishTask(sender: BaseVM, errorMessage: String?, dataArray: [NSObject]?)
    
}
