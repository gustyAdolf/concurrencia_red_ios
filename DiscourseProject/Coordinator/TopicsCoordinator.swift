//
//  TopicsCoordinator.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import UIKit

/// Coordinator que reprensenta la pila de navegación del topic list.
/// Tiene como hijo AddTopicCoordinator
class TopicsCoordinator: Coordinator {
    let presenter: UINavigationController
    let topicsDataManager: TopicsDataManager
    let topicDetailDataManager: TopicDetailDataManager
    let usersDataManager: UsersDataManager
    let addTopicDataManager: AddTopicDataManager
    var topicsViewModel: TopicsViewModel?
    
    init(presenter: UINavigationController, topicsDataManager: TopicsDataManager, topicDetailDataManager: TopicDetailDataManager, usersDataManager: UsersDataManager, addTopicDataManager: AddTopicDataManager) {
        self.presenter = presenter
        self.topicsDataManager = topicsDataManager
        self.topicDetailDataManager = topicDetailDataManager
        self.usersDataManager = usersDataManager
        self.addTopicDataManager = addTopicDataManager
    }
    
    override func start() {
        let topicsViewModel = TopicsViewModel(topicsDataManager: topicsDataManager, usersDataManager: usersDataManager)
        let topicsViewController = TopicsViewController(viewModel: topicsViewModel)
        
        topicsViewController.title = NSLocalizedString("Topics", comment: "")
        topicsViewModel.viewDelegate = topicsViewController
        topicsViewModel.coordinatorDelegate = self
        self.topicsViewModel = topicsViewModel
        presenter.pushViewController(topicsViewController, animated: false)
    }
    
    override func finish() {}
}

extension TopicsCoordinator: TopicsCoordinatorDelegate {
    
    func didSelect(topic: Topic) {
        let topicDetailViewModel = TopicDetailViewModel(topicId: topic.id ?? 0, topicDetailDataManager: topicDetailDataManager)
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.coordinatorDelegate = self
        topicDetailViewModel.viewDelegate = topicDetailViewController
        presenter.pushViewController(topicDetailViewController, animated: false)
    }
    
    func topicsPlusButtonTapped() {
        let addTopicCoordinator = AddTopicCoordinator(presenter: presenter, addTopicDataManager: addTopicDataManager)
        addChildCoordinator(addTopicCoordinator)
        addTopicCoordinator.start()
        
        addTopicCoordinator.onCancelTapped = { [weak self] in
            guard let self = self else {return}
            
            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
        }
        
        addTopicCoordinator.onTopicCreated = { [weak self] in
            guard let self = self else {return}
            
            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
            self.topicsViewModel?.refreshTopics()
        }
    }
    
}

extension TopicsCoordinator: TopicDetailCoordinatorDelegate {
    func topicDeleted() {
        presenter.popViewController(animated: true)
        topicsViewModel?.refreshTopics()
    }
    
    func topicDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
        topicsViewModel?.viewWasLoaded()
    }
    
    
}
