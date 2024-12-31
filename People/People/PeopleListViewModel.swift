//
//  PeopleListViewModel.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import Foundation

final class PeopleListViewModel {
    
    weak var delegate: ViewModelDelegate?
    var peopleList: [Person] = []
    
    func fetchPeopleList() async {
        let result = await NetworkManager().fetchPeople(page: "1")
        switch result {
        case .success(let list):
            peopleList += list.list
            delegate?.peopleListFetched()
        case .failure(let error):
            delegate?.peopleListFetchedFailed()
        }
    }
}
