//
//  AddTopicDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 15/1/21.
//

import Foundation

protocol AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
}
