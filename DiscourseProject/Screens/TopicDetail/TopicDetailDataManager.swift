//
//  TopicDetailDataManager.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

protocol TopicDetailDataManager {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<EmptyTopicResponse?, Error>) -> ())
}
