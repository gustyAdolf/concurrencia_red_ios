//
//  UserDetailViewController.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 17/1/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var viewModel: UserDetailViewModel
    
    lazy var username: UILabel = {
        let usernameUI = UILabel()
        usernameUI.translatesAutoresizingMaskIntoConstraints = false
        return usernameUI
    }()
    
    lazy var name: UITextField = {
        let nameUI = UITextField()
        nameUI.translatesAutoresizingMaskIntoConstraints = false
        nameUI.isUserInteractionEnabled = false
        return nameUI
    }()
    
    lazy var email: UILabel = {
        let emailUI = UILabel()
        emailUI.translatesAutoresizingMaskIntoConstraints = false
        return emailUI
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Actualizar", comment: ""), for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let nameField = stackViewAddingTitle(labelTitle: "Name: ", labelData: name)
        view.addSubview(nameField)
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        
        let usernameField = stackViewAddingTitle(labelTitle: "Username: ", labelData: username)
        view.addSubview(usernameField)
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            usernameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        
        let emailField = stackViewAddingTitle(labelTitle: "Email: ", labelData: email)
        view.addSubview(emailField)
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 10),
            emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        
        view.addSubview(updateButton)
        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            updateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            updateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    private func stackViewAddingTitle(labelTitle: String, labelData: UIView) -> UIStackView{
        let labTitleUI = UILabel()
        labTitleUI.translatesAutoresizingMaskIntoConstraints = false
        labTitleUI.text = NSLocalizedString(labelTitle, comment: "")
        let stackView = UIStackView(arrangedSubviews: [labTitleUI, labelData])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    @objc fileprivate func updateUser() {
        guard let newName = name.text else {return}
        viewModel.updateNameUser(newName: newName)
    }
    
    fileprivate func updateUI() {
        name.text = viewModel.user?.name
        username.text = viewModel.user?.username
        email.text = viewModel.user?.email
        
        guard let canEditName: Bool = viewModel.user?.canEditName else {return}
        if canEditName {
            name.isUserInteractionEnabled = true
            updateButton.isHidden = false
        }
    }
    
    fileprivate func showErrorFetchingDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user detail\nPlesase try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showUserUpdatedAlert() {
        let alertMessage: String = NSLocalizedString("User updated.", comment: "")
        showAlert(alertMessage, alertTitle: "OK!")
    }
    
    fileprivate func showErrorUserUpdatedAlert() {
        let alertMessage: String = NSLocalizedString("Error updating user\nPlesase try again later", comment: "")
        showAlert(alertMessage)
    }
    
}

extension UserDetailViewController: UserDetailViewDelegate {
    func failUserFetched() {
        showErrorFetchingDetailAlert()
    }
    
    func userDetailFetched() {
        updateUI()
    }
    
    func userUpdatedSuccessFully() {
        showUserUpdatedAlert()
    }
    
    func failUpdatingUser() {
        showErrorUserUpdatedAlert()
    }
    
    
}
