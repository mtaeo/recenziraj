//
//  ProfileViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()
    
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
    
    private lazy var userInfoContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var usernameTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.setupWith(title: "Username", placeholder: "")
        textFieldView.textField.backgroundColor = UIColor(named: "background_color")
        textFieldView.textField.text = viewModel.getUserDisplayName()
        return textFieldView
    }()
    
    private lazy var emailTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.setupWith(title: "Email", placeholder: "john.doe@mail.com")
        textFieldView.textField.backgroundColor = UIColor(named: "background_color")
        textFieldView.textField.isEnabled = false
        textFieldView.textField.textColor = .darkGray
        textFieldView.textField.text = viewModel.getUserEmail()
        return textFieldView
    }()
    
    private lazy var saveUserInfoChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self,
                         action: #selector(saveUserInfoChangesButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var verificationStatusContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var verifiedStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Verified"
        return label
    }()
    
    private lazy var verifiedBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        let tintColor = viewModel.isUserVerified() ? UIColor.systemBlue : UIColor.darkGray
        imageView.image = UIImage(systemName: "checkmark.circle")?.withTintColor(tintColor)
        return imageView
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
    
    private lazy var verifyAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resend Account Verification Email", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self,
                         action: #selector(verifyAccountButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        addSubviews()
        makeConstraints()
        fetchAndSetupProfileImage()
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func addSubviews() {
        profileContainerView.addArrangedSubview(profileImageView)
        profileContainerView.addArrangedSubview(submitProfileImageButton)
        view.addSubview(profileContainerView)
        
        addVerificationStatusContainerViewArrangedSubviews()
        userInfoContainerView.addArrangedSubview(verificationStatusContainerView)
        userInfoContainerView.addArrangedSubview(emailTextFieldView)
        userInfoContainerView.addArrangedSubview(usernameTextFieldView)
        userInfoContainerView.addArrangedSubview(saveUserInfoChangesButton)
        view.addSubview(userInfoContainerView)
        
        view.addSubview(logoutButton)
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
        
        userInfoContainerView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailTextFieldView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        usernameTextFieldView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        verifiedBadgeImageView.snp.makeConstraints {
            $0.size.equalTo(25)
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(75)
        }
    }
    
    @objc func submitProfileImageButtonPressed(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    @objc func saveUserInfoChangesButtonPressed() {
        startSpinner()
        usernameTextFieldView.resignFirstResponder()
        viewModel.updateDisplayName(username: usernameTextFieldView.textField.text) { [weak self] error in
            if error == nil {
                self?.viewModel.showAlert?("User Profile Change",
                                    "You have successfully updated your username.",
                                    "Confirm")
            } else {
                self?.viewModel.showAlert?("Error",
                                    error?.localizedDescription,
                                    "Confirm")
            }
            self?.stopSpinner()
        }
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
    
    @objc func verifyAccountButtonTapped() {
        viewModel.showAlert?("Account Verification",
                            "Please check your email for further account verification steps.",
                            "Confirm")
        viewModel.sendAccountVerification()
    }
    
    func addVerificationStatusContainerViewArrangedSubviews() {
        if viewModel.isUserVerified() {
            verificationStatusContainerView.addArrangedSubview(verifiedStatusLabel)
            verificationStatusContainerView.addArrangedSubview(verifiedBadgeImageView)
        } else {
            verificationStatusContainerView.addArrangedSubview(verifyAccountButton)
        }
    }
    
    func fetchAndSetupProfileImage() {
        viewModel.downloadProfileImage { [weak self] data, error in
            if let data = data {
                self?.profileImageView.image = UIImage.init(data: data)
            }
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        usernameTextFieldView.textField.resignFirstResponder()
    }
}

extension ProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let image = image {
            viewModel.uploadProfileImage(image) { [weak self] metadata, error in
                if error != nil {
                    self?.viewModel.showAlert?("Error",
                                               "There was an erorr while trying to upload your profile picture.",
                                               "Confirm")
                } else {
                    self?.profileImageView.image = image
                }
            }
        } else {
            viewModel.showAlert?("Error",
                                "There was an error while selecting your image. Please try again.",
                                "Confirm")
        }
    }
    
}
