//
//  CategoriesRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

struct CategoriesRequest: APIRequest {    
    typealias Response = CategoriesResponse
    
    var method: Method = .GET
    
    var path: String = "/categories.json"
    
    var parameters: [String : String] = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = [:]
        
}
