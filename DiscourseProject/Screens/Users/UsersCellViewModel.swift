//
//  UsersCellViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

class UsersCellViewModel {
    var user: User
    let usersDataManager: UsersDataManager?
    
    init(user: User, usersDataManager: UsersDataManager?) {
        self.user = user
        self.usersDataManager = usersDataManager
    }
    
    func getUserDataImage(completion: @escaping (Data?) -> () ) {
        guard let usersDataManager = usersDataManager else { return }
        guard let usrImgUrl = user.avatarTemplate else { return }
        usersDataManager.fetchUserImage(imageUrlReference: usrImgUrl) { result in
            switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
