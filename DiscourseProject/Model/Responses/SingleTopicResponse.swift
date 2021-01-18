//
//  SingleTopicResponse.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let singleTopicResponse = try? newJSONDecoder().decode(SingleTopicResponse.self, from: jsonData)

import Foundation

// MARK: - SingleTopicResponse
struct SingleTopicResponse: Codable {
    let postStream: PostStream?
    let id: Int?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case postStream = "post_stream"
        case id, title
    }
}


// MARK: - PostStream
struct PostStream: Codable {
    let posts: [Post]?
}

// MARK: - Post
struct Post: Codable {
    let cooked: String?
    let canEdit: Bool?
    
    enum CodingKeys: String, CodingKey {
        case cooked
        case canEdit = "can_edit"
    }
}
