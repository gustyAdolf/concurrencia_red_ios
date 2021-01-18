//
//  CategoriesCell.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet var categoryTitle: UILabel!
    @IBOutlet var categoryDescription: UILabel!
    
    var viewModel: CategoriesCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            self.categoryTitle.text = viewModel.category.name
            self.categoryDescription.text = viewModel.category.categoryDescription
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryTitle.text = nil
        self.categoryDescription.text = nil
    }
}
