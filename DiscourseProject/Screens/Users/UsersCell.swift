//
//  UsersCell.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import UIKit

class UsersCell: UITableViewCell {

    
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var nickname: UILabel!
    @IBOutlet var name: UILabel!
    
    
    var viewModel: UsersCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            nickname.text = viewModel.user.username
            name.text = viewModel.user.name
            userImg.layer.masksToBounds = true
            userImg.layer.cornerRadius = userImg.bounds.width / 2
            viewModel.getUserDataImage { [weak self] data in
                guard let data = data else {return}
                self?.userImg.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
        self.nickname.text = nil
        self.userImg.image = nil
    }
    
}
