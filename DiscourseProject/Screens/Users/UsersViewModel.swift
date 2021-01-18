//
//  UsersViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

protocol UsersViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

class UsersViewModel {
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    let usersDataManager: UsersDataManager
    var usersViewModel: [UsersCellViewModel] = []
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        usersDataManager.fetchAllUsers { result in
            switch result {
                case .success(let usersResponse):
                    usersResponse?.directoryItems?.forEach { [weak self] userResponse in
                        guard let user = userResponse.user else {return}
                        self?.usersViewModel.append(UsersCellViewModel(user: user, usersDataManager: self?.usersDataManager))
                    }
                    self.viewDelegate?.topicsFetched()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return usersViewModel.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UsersCellViewModel? {
        guard indexPath.row < usersViewModel.count else {return nil}
        return usersViewModel[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < usersViewModel.count else {return}
        coordinatorDelegate?.didSelect(user: usersViewModel[indexPath.row].user)
    }
    
    func refreshUsers() {
        usersViewModel.removeAll()
        viewWasLoaded()
    }
}
