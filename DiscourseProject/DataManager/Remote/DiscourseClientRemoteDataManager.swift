//
//  DiscourseClientRemoteDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol DiscourseClientRemoteDataManager {
    // TOPICS
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
    
    // TOPIC DETAIL
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<EmptyTopicResponse?,Error>) -> ())
    
    // ADD TOPIC
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
    
    // USERS
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ())
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
    
    // USER DETAILS
    func fetchSingleUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    
    func updateUserName(username: String, newName: String, completion: @escaping (Result<UserUpdateResponse?,Error>) -> ())
    
    // CATEGORIES
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) ->())
}
