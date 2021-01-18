//
//  AppCoordinator.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interaciones con la Window.
/// Tiene tres hijos, topic list, categories list y user list (uno para cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()
    
    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
       return DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
    }()
    
    lazy var localDataManager: DiscourseClientLocalDataManager = {
        return DiscourseClientLocalDataManagerImpl()
    }()
    
    
    lazy var dataManager: DiscourseClientDataManager = {
        return DiscourseClientDataManager(localDataManager: localDataManager, remoteDataManager: self.remoteDataManager)
    }()
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        // HOME app 3 bars
        let tabBarController = UITabBarController()
        
        // TOPICS
        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController, topicsDataManager: dataManager, topicDetailDataManager: dataManager, usersDataManager: dataManager, addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()
        
        // CATEGORIES
        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(presenter: categoriesNavigationController, categoriesDataManager: dataManager)
        addChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.start()
        
        // USERS
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDetailDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()
        
        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = [topicsNavigationController, categoriesNavigationController, usersNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(systemName: "list.dash")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "tag")
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "person.2.fill")

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
    }
    
    override func finish() {}
    
}
