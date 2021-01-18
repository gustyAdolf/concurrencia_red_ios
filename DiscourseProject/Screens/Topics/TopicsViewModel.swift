//
//  TopicsViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

/// Delegate para comunicarnos con el coordinator para la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate para comunicar a la vista los eventos que pintar
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    let usersDataManager: UsersDataManager
    var topicViewModels: [TopicCellViewModel] = []
    
    init(topicsDataManager: TopicsDataManager, usersDataManager: UsersDataManager) {
        self.topicsDataManager = topicsDataManager
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        topicsDataManager.fetchAllTopics { [weak self] result in
            switch result {
                case .success(let latestTopics):
                    
                    latestTopics?.topicList.topics.forEach { [weak self] topic in
                        guard let usrTopicOwner = latestTopics?.users.first(where: { usr -> Bool in
                            return topic.posters[0].userID == usr.id
                        }) else {return}
                        self?.topicViewModels.append(TopicCellViewModel(topic: topic, userTopicOwner: usrTopicOwner, usersDataManager: self?.usersDataManager))
                    }
                    // Recargar
                    self?.viewDelegate?.topicsFetched()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }
    
    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }
    
    func refreshTopics() {
        topicViewModels.removeAll()
        viewWasLoaded()
    }
    
}
