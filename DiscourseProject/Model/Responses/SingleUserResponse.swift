//
//  SingleUserResponse.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 17/1/21.
//

import Foundation

// MARK: - SingleUserResponse
struct SingleUserResponse: Codable {
    let user: PurpleUser?
    
    enum CodingKeys: String, CodingKey {
        case user
    }
}

// MARK: - PurpleUser
struct PurpleUser: Codable {
    let id: Int?
    var name: String?
    let username, avatarTemplate, email: String?
    let canEdit, canEditUsername, canEditEmail, canEditName: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case email
        case canEdit = "can_edit"
        case canEditUsername = "can_edit_username"
        case canEditEmail = "can_edit_email"
        case canEditName = "can_edit_name"
    }
}
