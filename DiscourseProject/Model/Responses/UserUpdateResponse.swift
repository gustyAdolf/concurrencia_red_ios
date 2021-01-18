//
//  UserUpdateResponse.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 18/1/21.
//

import Foundation

// MARK: - UserUpdateResponse
struct UserUpdateResponse: Codable {
    let success: String?
    let user: User?
}
