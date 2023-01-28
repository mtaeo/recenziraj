//
//  ProfileViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private lazy var profileContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder_profile_image")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor(named: "border_color")?.cgColor
        return imageView
    }()
    
    private lazy var submitProfileImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit Photo", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self,
                         action: #selector(submitProfileImageButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.red.withAlphaComponent(0.6), for: .normal)
        button.addTarget(self,
                         action: #selector(logoutButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var emailTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.setupWith(title: "Email", placeholder: "john.doe@mail.com")
        textFieldView.textField.backgroundColor = UIColor(named: "background_color")
        textFieldView.textField.isEnabled = false
        textFieldView.textField.text = viewModel.getUserEmail()
        return textFieldView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        addSubviews()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
}

private extension ProfileViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "background_color")
        navigationController?.navigationBar.topItem?.title = "Profile Settings"
    }
    
    func addSubviews() {
        profileContainerView.addArrangedSubview(profileImageView)
        profileContainerView.addArrangedSubview(submitProfileImageButton)
        view.addSubview(profileContainerView)
        view.addSubview(emailTextFieldView)
        view.addSubview(logoutButton)
        
        emailTextFieldView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    func makeConstraints() {
        profileContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview()
            $0.height.equalTo(175)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.size.equalTo(125)
        }
        
        emailTextFieldView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(75)
        }
    }
    
    @objc func submitProfileImageButtonPressed() {
        print("PRESSED  PROFILE IMAGE SUBMIT")
    }
    
    @objc func logoutButtonTapped() {
        logoutConfirmationAlert()
    }
    
    func logoutConfirmationAlert() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout out of this account?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes, Logout", style: .destructive, handler: { [weak self] (action) in
            self?.viewModel.onLogoutButtonPressed?()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
