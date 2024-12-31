//
//  PersonDetailViewModel.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import Foundation

final class PersonDetailViewModel {
    
    var personId: String = ""
    
    weak var delegate: PersonDetailViewModelDelegate?
    
    func fetchPersonDetails() async {
        let networkManager = NetworkManager()
        async let personDetails = networkManager.fetchPersonDetails(personId: personId)
        async let images = networkManager.fetchPersonImages(personId: personId)
        let (fetchedPersonDetails, fetchedImages) = await (personDetails, images)
        print(fetchedPersonDetails, fetchedImages)
        var detail: PersonItem? = nil
        var imagesPerson: Images? = nil
        
        switch fetchedPersonDetails {
        case .success(let item):
            detail = item
        case .failure(_):
            break
        }
        
        switch fetchedImages {
        case .success(let item):
            imagesPerson = item
        case .failure(_):
            break
        }
        if let detail, let imagesPerson {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.peopleDetailFetched(personDetail: detail, images: imagesPerson)
            }
        }
    }
}
