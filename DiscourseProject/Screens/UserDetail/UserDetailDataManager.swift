//
//  UserDetailDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 18/1/21.
//

import Foundation

protocol UserDetailDataManager {
    func fetchSingleUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    
    func updateUserName(username: String, newName: String, completion: @escaping (Result<UserUpdateResponse?,Error>) -> ())
}
