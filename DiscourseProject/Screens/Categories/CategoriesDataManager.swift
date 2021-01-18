//
//  CategoriesDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

protocol CategoriesDataManager {
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) ->())
}
