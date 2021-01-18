//
//  LatestTopicRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

struct LatestTopicsRequest: APIRequest {
    typealias Response = LatestTopicsResponse
    
    var method: Method = .GET
    
    var path: String = "/latest.json"
    
    var parameters: [String : String] = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = [:]
        
    
}
