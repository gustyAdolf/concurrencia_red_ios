//
//  UsersResponse.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

// MARK: - Welcome
struct UsersResponse: Codable {
    let directoryItems: [DirectoryItem]?

    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}

// MARK: - DirectoryItem
struct DirectoryItem: Codable {
    let user: User?

    enum CodingKeys: String, CodingKey {
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let username: String?
    let name: String?
    let avatarTemplate: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case title
    }
}

