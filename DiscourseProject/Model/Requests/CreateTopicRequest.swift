//
//  CreateTopicRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 15/1/21.
//

import Foundation

struct CreateTopicRequest: APIRequest {
    typealias Response = AddNewTopicResponse
    
    let title: String
    let raw: String
    let createdAt: String
    
    init(title: String,
         raw: String,
         createdAt: String) {
        self.title = title
        self.raw = raw
        self.createdAt = createdAt
    }
    
    var method: Method = .POST
    
    var path: String = "/posts.json"
    
    var parameters: [String : String] = [ : ]
    
    var body: [String : Any] {
        return [
            "title" : title,
            "raw" : raw,
            "createdAt" : createdAt
        ]
    }
    
    var headers: [String : String] = [ : ]
}
