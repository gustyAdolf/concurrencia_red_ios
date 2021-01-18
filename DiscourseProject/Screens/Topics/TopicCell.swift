//
//  TopicCell.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet var usrImg: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var topicTitle: UILabel!
    @IBOutlet var topicReplies: UILabel!
    @IBOutlet var topicViews: UILabel!
    @IBOutlet var topicCreatedAt: UILabel!
    @IBOutlet var deletedField: UILabel!
        
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            username.text = viewModel.userTopicOwner.username
            topicTitle.text = viewModel.topic.title
            topicReplies.text = String(viewModel.topic.replyCount ?? 0)
            topicViews.text = String(viewModel.topic.views ?? 0)
            topicCreatedAt.text = viewModel.topic.createdAt?.formatedStringDate(toFormat: "MMM dd")
            if viewModel.topic.closed ?? false {
                deletedField.isHidden = false
            }
            usrImg.layer.masksToBounds = true
            usrImg.layer.cornerRadius = usrImg.bounds.width / 2
            viewModel.getUserDataImage { [weak self] data in
                guard let data = data else { return }
                self?.usrImg.image = UIImage(data: data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deletedField.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        username.text = nil
        topicTitle.text = nil
        topicReplies.text = nil
        topicViews.text = nil
        topicCreatedAt.text = nil
        usrImg.image = nil
        deletedField.isHidden = true
    }
}
