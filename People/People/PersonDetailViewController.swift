//
//  PersonDetailViewController.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import UIKit

final class PersonDetailViewController: UIViewController {
    @IBOutlet var infoLabel1: UILabel!
    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var infoLabel4: UILabel!
    @IBOutlet var infoLabel3: UILabel!
    @IBOutlet var infoLabel2: UILabel!
    
    let viewModel = PersonDetailViewModel()
    var personId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.personId = personId
        viewModel.delegate = self
        fetchDetails()
    }
    
    func fetchDetails() {
        Task {
            await viewModel.fetchPersonDetails()
        }
    }

}

extension PersonDetailViewController: PersonDetailViewModelDelegate {
    func peopleDetailFetched(personDetail: PersonItem, images: Images) {
        infoLabel1.text = personDetail.name
        infoLabel2.text = personDetail.knownForDepartment
        infoLabel3.text = personDetail.placeOfBirth
        infoLabel4.text = personDetail.birthday
        detailLabel.text = personDetail.biography
    }
    
    func peopleDetailFetchedFailed() {
        
    }
    
    
}
