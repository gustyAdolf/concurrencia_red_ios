//
//  CategoriesResponse.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

// MARK: - Categories
struct CategoriesResponse: Codable {
    let categoryList: CategoryList?
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let categories: [Category]?

    enum CodingKeys: String, CodingKey {
        case categories
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name, color: String?
    let categoryDescription, descriptionText: String?
   
    enum CodingKeys: String, CodingKey {
        case id, name, color
        case categoryDescription = "description"
        case descriptionText = "description_text"
    }
}

