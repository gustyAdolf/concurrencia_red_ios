//
//  UserUpdateRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 18/1/21.
//

import Foundation

struct UserUpdateRequest: APIRequest {
    
    typealias Response = UserUpdateResponse
    
    let username: String
    let name: String
    
    init(username: String, name: String) {
        self.username = username
        self.name = name
    }
    
    var method: Method = .PUT
    
    var path: String {
        return "/u/\(self.username).json"
    }
    
    var parameters: [String : String] = [ : ]
    
    var body: [String : Any] {
        return [
            "name" : self.name
        ]
    }
    
    var headers: [String : String] = [ : ]
    
}
