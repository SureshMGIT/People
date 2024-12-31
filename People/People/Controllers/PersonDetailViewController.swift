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
    @IBOutlet var loaderContainer: UIView!
    @IBOutlet var infoLabel2: UILabel!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
    let viewModel = PersonDetailViewModel()
    var personId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.personId = personId
        viewModel.delegate = self
        activityIndicator.startAnimating()
        noDataLabel.isHidden = true
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
        loaderContainer.isHidden = true
        infoLabel1.text = personDetail.name
        infoLabel2.text = personDetail.knownForDepartment
        infoLabel3.text = personDetail.placeOfBirth
        infoLabel4.text = personDetail.birthday
        detailLabel.text = personDetail.biography
        imageCollectionView.reloadData()
        CacheManager().downloadImage(path: personDetail.profilePath ?? "", compltion: { [weak self] (image, inxpath) in
            self?.personImageView.image = image
        })
    }
    
    func peopleDetailFetchedFailed() {
        activityIndicator.isHidden = true
        noDataLabel.isHidden = false
    }
}

extension PersonDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imagesItemPerson.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GridCollectionViewCell
        cell?.personImageView.image = nil
        CacheManager().downloadImage(path: viewModel.imagesItemPerson[indexPath.row].filePath ?? "", indexpath: indexPath, compltion: { (image, inxpath) in
            guard let tableCell = collectionView.cellForItem(at: indexPath) as? GridCollectionViewCell else { return }
            if let image {
                tableCell.personImageView.image = image
            } else {
                tableCell.personImageView.image = nil
            }
        })
        return cell!
    }
}
