//
//  UsersDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

protocol UsersDataManager {
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ())
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}
