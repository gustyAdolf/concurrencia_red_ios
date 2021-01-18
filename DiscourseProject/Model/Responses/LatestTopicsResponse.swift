//
//  LatestTopicsResponse.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

// MARK: - LatesTopics
struct LatestTopicsResponse: Codable {
    let users: UsersTopic
    let topicList: TopicDataList
    
    enum CodingKeys: String, CodingKey {
        case users
        case topicList = "topic_list"
    }
}

// MARK: User Topics
typealias UsersTopic = [UserTopic]
struct UserTopic: Codable {
    let id: Int?
    let username: String?
    let name: String?
    let avatarTemplate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
    }
    
}

// MARK: - TopicList
struct TopicDataList: Codable {
    let topics: Topics
    
    enum CodingKeys: String, CodingKey {
        case topics
    }
}

// MARK: - Topic
typealias Topics = [Topic]
struct Topic: Codable {
    let id: Int?
    let title, fancyTitle: String?
    let postsCount, replyCount: Int?
    let createdAt: String?
    let visible, closed, archived: Bool?
    let views, likeCount: Int?
    let posters: Posters
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case fancyTitle = "fancy_title"
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case createdAt = "created_at"
        case visible, closed, archived, views
        case likeCount = "like_count"
        case posters
    }
}

// MARK: - Poster
typealias Posters = [Poster]
struct Poster: Codable {
    let userID: Int?
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}


// MARK: - TopicBodyPost
struct TopicRequest: Codable {
    let title: String?
    let topicId: Int?
    let raw: String?
    let category: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case topicId = "topic_id"
        case raw, category
        case createdAt = "created_at"
    }
}

