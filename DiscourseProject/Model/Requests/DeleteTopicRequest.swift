//
//  DeleteTopicRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 15/1/21.
//

import Foundation

struct EmptyTopicResponse: Codable {
    
}


struct DeleteTopicRequest: APIRequest {
    typealias Response = EmptyTopicResponse
    
    let topicId: Int
    
    init(topicId: Int) {
        self.topicId = topicId
    }
    
    var method: Method = .DELETE
    
    var path: String {
        return "/t/\(self.topicId).json"
    }
    
    var parameters: [String : String] = [ : ]
    
    var body: [String : Any] = [ : ]
    
    var headers: [String : String] = [ : ]
 
}
