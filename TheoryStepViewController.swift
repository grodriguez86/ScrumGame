//
//  TheoryStepViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/23/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class TheoryStepViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ContentVM()
    var step: Step?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = viewModel
        tableView.delegate = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(VideoItemCell.nib, forCellReuseIdentifier: VideoItemCell.identifier)
        tableView?.register(ImageItemCell.nib, forCellReuseIdentifier: ImageItemCell.identifier)
        tableView?.register(TextItemCell.nib, forCellReuseIdentifier: TextItemCell.identifier)
        tableView?.register(TitleItemCell.nib, forCellReuseIdentifier: TitleItemCell.identifier)
        tableView?.register(AnswerItemCell.nib, forCellReuseIdentifier: AnswerItemCell.identifier)
        
        print(step?.content)
        
        self.viewModel.getContent(for: step!)
    }
    
    
    func didFinishTask(sender: BaseVM, errorMessage: String?, dataArray: [NSObject]?) {
        self.tableView.reloadData()
    }
    
}
