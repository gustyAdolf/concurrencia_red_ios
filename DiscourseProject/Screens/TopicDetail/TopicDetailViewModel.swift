//
//  TopicDetailViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDeleted()
}

protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopic()
}

class TopicDetailViewModel {
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    weak var viewDelegate: TopicDetailViewDelegate?
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelCookedText: String?
    let topicDetailDataManager: TopicDetailDataManager
    let topicId: Int
    var isDeletable: Bool = false
    
    init(topicId: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicDetailDataManager = topicDetailDataManager
        self.topicId = topicId
    }
    
    func viewDidLoad() {
        topicDetailDataManager.fetchTopic(id: topicId) { [weak self] result in
            switch result {
                case .success(let singleTopic):
                    guard let labelTopicIDText = singleTopic?.id,
                          let labelTopicNameText = singleTopic?.title,
                          let labelCookedText = singleTopic?.postStream?.posts?[0].cooked,
                          let canEdit = singleTopic?.postStream?.posts?[0].canEdit else {return}
                    self?.labelTopicIDText = String(labelTopicIDText)
                    self?.labelTopicNameText = labelTopicNameText
                    self?.labelCookedText = labelCookedText
                    self?.isDeletable = canEdit
                    self?.viewDelegate?.topicDetailFetched()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
    
    func deleteTopic() {
        topicDetailDataManager.deleteTopic(id: self.topicId) { [weak self] result in
            switch result {
                case .success:
                    self?.coordinatorDelegate?.topicDeleted()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorDeletingTopic()
            }
        }
    }
}

