//
//  UsersCoordinator.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import UIKit

/// Coodinator que reprenseta el tab de Users list
class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDetailDataManager: UserDetailDataManager){
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: self.usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {

    }
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    func didSelect(user: User) {
        let userDetailViewModel = UserDetailViewModel(usrDetDataManager: userDetailDataManager, username: user.username ?? "")
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        userDetailViewModel.coordinatorDelegate = self
        userDetailViewModel.viewDelegate = userDetailViewController
        presenter.pushViewController(userDetailViewController, animated: false)
    }
}

extension UsersCoordinator: UserDetailCoordinatorDelegate {
    func userDetailbackButtonTapped(refresh: Bool) {
        presenter.popViewController(animated: true)
        if refresh {
            usersViewModel?.refreshUsers()
        }
    }
     
}
