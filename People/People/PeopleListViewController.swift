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
        viewModel.delegate = self
        Task {
           await viewModel.fetchPeopleList()
        }
    }
}

extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "person") as? PersonTableViewCell
        cell?.setupData(person: viewModel.peopleList[indexPath.row])
        return cell!
    }
}

extension PeopleListViewController: ViewModelDelegate {
    func peopleListFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func peopleListFetchedFailed() {
        
    }
}
