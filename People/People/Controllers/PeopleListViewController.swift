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
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        self.title = "People"
        showLoader()
        fetchList()
    }
    
    func showLoader() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func fetchList() {
        Task {
           await viewModel.fetchPeopleList()
        }
    }
}

extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.peopleList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "person") as? PersonTableViewCell
            cell?.setupData(person: viewModel.peopleList[indexPath.row])
            cell?.personImageView.image = nil
            CacheManager().downloadImage(path: viewModel.peopleList[indexPath.row].profilePath ?? "", indexpath: indexPath, compltion: { (image, inxpath) in
                guard let inxpath, let tableCell = tableView.cellForRow(at: inxpath) as? PersonTableViewCell else { return }
                if let image {
                    tableCell.personImageView.image = image
                } else {
                    tableCell.personImageView.image = nil
                }
            })
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loader") as? LoaderTableViewCell
            cell?.activityIndicatorView.startAnimating()
            fetchList()
            return cell!
        }
    }
}

extension PeopleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personId = viewModel.peopleList[indexPath.row].id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let personDetailViewController = storyboard.instantiateViewController(identifier: "PersonDetailViewController") as? PersonDetailViewController
        personDetailViewController?.personId = String(personId ?? 0)
        self.navigationController?.pushViewController(personDetailViewController!, animated: true)
    }
}

extension PeopleListViewController: ViewModelDelegate {
    func peopleListFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.isHidden = true
            self?.tableView.reloadData()
        }
    }
    
    func peopleListFetchedFailed() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.isHidden = true
            self?.tableView.isHidden = true
            let alert = UIAlertController(title: "Error", message: "No data available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true)
        }
    }
}
