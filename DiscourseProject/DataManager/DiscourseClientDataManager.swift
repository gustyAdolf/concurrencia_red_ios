//
//  DiscourseClientDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

/// DataManager de la app. Usa un localDataManager y un remoteDataManager que colaboran entre ellos
/// En las extensiones de abajo, encontramos la implementación de aquellos métodos necesarios en cada módulo de la app
/// Este DataManager sólo utiliza llamadas remotas, pero podría extenderse para serializar las respuestas, y poder implementar un offline first en el futuro
class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager
    
    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

// TOPICS
extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

// TOPIC DETAILS
extension DiscourseClientDataManager: TopicDetailDataManager {
    func deleteTopic(id: Int, completion: @escaping (Result<EmptyTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
    
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
}

// ADD TOPIC
extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
    
    
}

// USERS
extension DiscourseClientDataManager: UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
    
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        remoteDataManager.fetchUserImage(imageUrlReference: imageUrlReference, completion: completion)
    }
    
}

// USERS DETAILS
extension DiscourseClientDataManager: UserDetailDataManager {
    func fetchSingleUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ()) {
        remoteDataManager.fetchSingleUser(username: username, completion: completion)
    }
    
    func updateUserName(username: String, newName: String, completion: @escaping (Result<UserUpdateResponse?, Error>) -> ()) {
        remoteDataManager.updateUserName(username: username, newName: newName, completion: completion)
    }
}

// CATEGORIES

extension DiscourseClientDataManager: CategoriesDataManager {
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        remoteDataManager.fetchCategories(completion: completion)
    }
    
    
}
