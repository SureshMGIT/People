//
//  PeopleListViewController.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import UIKit

final class PeopleListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel = PeopleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

