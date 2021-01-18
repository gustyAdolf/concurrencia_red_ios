//
//  TopicCellViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

class TopicCellViewModel {
    let topic: Topic
    let userTopicOwner: UserTopic
    let usersDataManager: UsersDataManager?
    
    init(topic: Topic, userTopicOwner: UserTopic, usersDataManager: UsersDataManager?) {
        self.topic = topic
        self.userTopicOwner = userTopicOwner
        self.usersDataManager = usersDataManager
    }
    
    func getUserDataImage(completion: @escaping (Data?) -> () ) {
        guard let usersDataManager = usersDataManager else { return }
        usersDataManager.fetchUserImage(imageUrlReference: self.userTopicOwner.avatarTemplate ?? "") { result in
            switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
