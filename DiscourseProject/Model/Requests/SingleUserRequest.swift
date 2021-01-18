//
//  SingleUserRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 17/1/21.
//

import Foundation

struct SingleUserRequest: APIRequest {
    typealias Response = SingleUserResponse
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
    
    var method: Method = .GET
    
    var path: String {
        return "/users/\(self.username).json"
    }
    
    var parameters: [String : String] = [ : ]
    
    var body: [String : Any] = [ : ]
    
    var headers: [String : String] = [ : ]
    
    
}
