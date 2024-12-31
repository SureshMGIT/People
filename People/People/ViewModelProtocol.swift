//
//  ViewModelProtocol.swift
//  People
//
//  Created by Suresh M on 31/12/24.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func peopleListFetched()
    func peopleListFetchedFailed()
}

protocol PersonDetailViewModelDelegate: AnyObject {
    func peopleDetailFetched(personDetail: PersonItem, images: Images)
    func peopleDetailFetchedFailed()
}
