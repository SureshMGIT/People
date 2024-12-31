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
    var currentPage = 0
    var isFetching = false
    
    func fetchPeopleList() async {
        guard !isFetching else { return }
        isFetching = true
        currentPage += 1
        let result = await NetworkManager().fetchPeople(page: String(currentPage))
        switch result {
        case .success(let list):
            peopleList += list.list
            delegate?.peopleListFetched()
            isFetching = false
        case .failure(_):
            delegate?.peopleListFetchedFailed()
            isFetching = false
        }
    }
}
