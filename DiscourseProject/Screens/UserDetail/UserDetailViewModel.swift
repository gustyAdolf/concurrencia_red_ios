//
//  UserDetailViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 17/1/21.
//

import Foundation

protocol UserDetailCoordinatorDelegate: class {
    func userDetailbackButtonTapped(refresh: Bool)
}

protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func failUserFetched()
    
    func userUpdatedSuccessFully()
    func failUpdatingUser()
}

class UserDetailViewModel {
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    weak var viewDelegate: UserDetailViewDelegate?
    let usrDetDataManager: UserDetailDataManager
    let username: String
    var user: PurpleUser?
    private var userIsUpdated: Bool = false
    
    
    init(usrDetDataManager: UserDetailDataManager, username: String) {
        self.usrDetDataManager = usrDetDataManager
        self.username = username
    }
    
    func viewWasLoaded(){
        usrDetDataManager.fetchSingleUser(username: self.username) { [weak self] result in
            switch result {
                case .success(let userSingleResponse):
                    guard let usr = userSingleResponse?.user else {return}
                    self?.user = usr
                    self?.viewDelegate?.userDetailFetched()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.failUserFetched()
            }
        }
    }
    
    func updateNameUser(newName: String) {
        usrDetDataManager.updateUserName(username: self.username, newName: newName) { [weak self] result in
            switch result {
                case .success:
                    self?.userIsUpdated = true
                    self?.viewDelegate?.userUpdatedSuccessFully()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.failUpdatingUser()
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailbackButtonTapped(refresh: self.userIsUpdated)
    }
    
}
