//
//  AddTopicViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 15/1/21.
//

import Foundation


protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

protocol AddTopicViewDelegate: class {
    func errorAddingTopic()
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let addTopicDataManager: AddTopicDataManager
    
    init(addTopicDataManager: AddTopicDataManager) {
        self.addTopicDataManager = addTopicDataManager
    }
    
    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }
    
    func submitButtonTapped(title: String, raw: String) {
        let dateFormatter = DateFormatter()
        addTopicDataManager.addTopic(title: title, raw: raw, createdAt: dateFormatter.string(from: Date())) { [weak self] result in
            switch result {
                case .success:
                    self?.coordinatorDelegate?.topicSuccessfullyAdded()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorAddingTopic()
            }
        }
    }
}
