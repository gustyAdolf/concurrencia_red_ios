//
//  CategoriesCoordinator.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import UIKit

/// Coordinator que reprenseta el tab de Categories list
class CategoriesCoordinator: Coordinator {
    let presenter: UINavigationController
    let categoriesDataManager: CategoriesDataManager
    var categoriesViewModel: CategoriesViewModel?
    
    init(presenter: UINavigationController, categoriesDataManager: CategoriesDataManager) {
        self.presenter = presenter
        self.categoriesDataManager = categoriesDataManager
    }
    
    override func start() {
        let categoriesViewModel = CategoriesViewModel(categoriesDataManager: categoriesDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewController.title = NSLocalizedString("Categories", comment: "")
        categoriesViewModel.viewDelegate = categoriesViewController
        self.categoriesViewModel = categoriesViewModel
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {
        
    }
}
