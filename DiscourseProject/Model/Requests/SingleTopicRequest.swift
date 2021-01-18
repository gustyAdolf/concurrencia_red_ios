//
//  SingleTopicRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

struct SingleTopicRequest: APIRequest {
    typealias Response = SingleTopicResponse
    
    let topicId: Int
    
    init(topicId: Int) {
        self.topicId = topicId
    }
    
    var method: Method = .GET
    
    var path: String {
        return "/t/\(self.topicId).json"
    }
    
    var parameters: [String : String] = [ : ]
    
    var body: [String : Any] = [ : ]
    
    var headers: [String : String] = [ : ]
  
}
