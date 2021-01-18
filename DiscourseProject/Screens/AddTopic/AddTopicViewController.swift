//
//  AddTopicViewController.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 15/1/21.
//

import UIKit

class AddTopicViewController: UIViewController {

    let viewModel: AddTopicViewModel
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = NSLocalizedString("Insert topic title and tab Submit", comment: "")
        return textField
    }()
    
    lazy var rawField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = NSLocalizedString("Type here. Use Markdown, BBCode, or HTML to format.", comment: "")
        return textField
    }()
    init(viewModel: AddTopicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(rawField)
        NSLayoutConstraint.activate([
            rawField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            rawField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            rawField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
        ])
        
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            submitButton.topAnchor.constraint(equalTo: rawField.bottomAnchor, constant: 8)
        ])
        
        let rightBarButtomItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        rightBarButtomItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtomItem
    }
    
    @objc fileprivate func submitButtonTapped() {
        guard let text = textField.text, !text.isEmpty else {return}
        guard let raw = rawField.text, !raw.isEmpty else {return}
        viewModel.submitButtonTapped(title: text, raw: raw)
    }
    
    @objc fileprivate func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }
    
    fileprivate func showErrorAddingTopicAlert() {
        let message = NSLocalizedString("Error adding topic\nPlease try again later", comment: "")
        showAlert(message)
    }
}

extension AddTopicViewController: AddTopicViewDelegate {
    func errorAddingTopic() {
        showErrorAddingTopicAlert()
    }
    
    
}
