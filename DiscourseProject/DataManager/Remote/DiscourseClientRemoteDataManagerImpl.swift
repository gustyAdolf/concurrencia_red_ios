//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

/// Implemetanción por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    let session: SessionAPI
    
    init(session: SessionAPI) {
        self.session = session
    }
    
    // TOPICS
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    // TOPIC DETAIL
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(topicId: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<EmptyTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(topicId: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    
    // ADD TOPIC
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    // USERS
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        let request = UserImageRequest(imageUrl: imageUrlReference).requestWithBaseUrl()
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        let request = UsersRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    // USER DETAILS
    func fetchSingleUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ()) {
        let request = SingleUserRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func updateUserName(username: String, newName: String, completion: @escaping (Result<UserUpdateResponse?, Error>) -> ()) {
        let request = UserUpdateRequest(username: username, name: newName)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    // CATEGORIES
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        let request = CategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }
}
