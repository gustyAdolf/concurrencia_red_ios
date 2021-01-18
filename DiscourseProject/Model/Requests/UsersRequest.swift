//
//  UsersRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

struct UsersRequest: APIRequest {
    typealias Response = UsersResponse
    
    var method: Method = .GET
    
    var path: String = "/directory_items.json"
    
    var parameters: [String : String] {
        return ["period" : "weekly",
                "order" : "likes_received"]
    }
    
    var body: [String : Any] = [ : ]
    
    var headers: [String : String] = [ : ]
    
}
