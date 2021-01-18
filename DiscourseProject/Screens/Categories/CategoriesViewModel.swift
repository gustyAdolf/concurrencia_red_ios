//
//  CategoriesViewModel.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import Foundation

protocol CategoriesViewDelegate: class {
    func categoriesFetched()
    func errorFetchingCategories()
}

class CategoriesViewModel {
    weak var viewDelegate: CategoriesViewDelegate?
    let categoriesDataManager: CategoriesDataManager
    var categoriesViewModel: [CategoriesCellViewModel] = []
    
    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }
        
    func viewWasLoaded() {
        categoriesDataManager.fetchCategories { [weak self] result in
            switch result {
                case .success(let categoriesResponse):
                    categoriesResponse?.categoryList?.categories?.forEach {  category in
                        self?.categoriesViewModel.append(CategoriesCellViewModel(category: category))
                    }
                    self?.viewDelegate?.categoriesFetched()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return categoriesViewModel.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CategoriesCellViewModel? {
        guard indexPath.row < categoriesViewModel.count else {return nil}
        return categoriesViewModel[indexPath.row]
    }
   
}
