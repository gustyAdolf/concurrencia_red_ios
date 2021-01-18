//
//  TopicDetailViewController.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 14/1/21.
//

import UIKit

class TopicDetailViewController: UIViewController {
    
    let viewModel: TopicDetailViewModel
    
    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var labelTopicCooked: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black
        
        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal
                
        return topicIDStackView
    }()
    
    lazy var topicNameStackView: UIStackView = {
        let labelTopicNameTitle = UILabel()
        labelTopicNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicNameTitle.text = NSLocalizedString("Topic name: ", comment: "")
        
        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicNameTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal
        topicNameStackView.alignment = .center
        topicNameStackView.distribution = .fillProportionally
        
        return topicNameStackView
    }()
    
    lazy var topicCookedStackView: UIStackView = {
        let labelTopicCookedTitle = UILabel()
        labelTopicCookedTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicCookedTitle.text = NSLocalizedString("First message: ", comment: "")
        
        let topicCookedStackView = UIStackView(arrangedSubviews: [labelTopicCookedTitle, labelTopicCooked])
        topicCookedStackView.translatesAutoresizingMaskIntoConstraints = false
        topicCookedStackView.axis = .horizontal
        topicCookedStackView.alignment = .center
        topicCookedStackView.distribution = .fillProportionally
        
        return topicCookedStackView
    }()
    
    init(viewModel: TopicDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicCookedStackView)
        NSLayoutConstraint.activate([
            topicCookedStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicCookedStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            topicCookedStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
        ])
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    fileprivate func updateUI(){
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        labelTopicCooked.text = viewModel.labelCookedText
        
        if viewModel.isDeletable {
            let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTopic))
            rightBarButtonItem.tintColor = .black
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    @objc private func deleteTopic() {
        viewModel.deleteTopic()
    }
    
    fileprivate func showErrorFetchingDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlesase try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorDeletingTopicAlert() {
        let alertMessage: String = NSLocalizedString("Error deleting this topic\nPlesase try again later", comment: "")
        showAlert(alertMessage)
    }

}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func errorDeletingTopic() {
        showErrorDeletingTopicAlert()
    }
    
    func topicDetailFetched() {
        updateUI()
    }
    
    func errorFetchingTopicDetail() {
        showErrorFetchingDetailAlert()
    }
    
    
}
