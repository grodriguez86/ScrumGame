//
//  TheoricalStepViewController.swift
//  scrum-ios
//
//  Created by Matias Glessi on 8/8/18.
//  Copyright © 2018 Matias Glessi. All rights reserved.
//

import UIKit

class TheoricalStepViewController: UIViewController, UITableViewDelegate, BaseVMDelegate {
    
    func didFinishTask(sender: BaseVM, errorMessage: String?, dataArray: [NSObject]?) {
        self.tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ContentVM()
    
    // https://medium.com/@stasost/ios-how-to-build-a-table-view-with-multiple-cell-types-2df91a206429
   
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

        self.viewModel.getContent(for: Step())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }

}

