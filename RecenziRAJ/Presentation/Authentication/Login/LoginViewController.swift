//
//  LoginViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 31.08.2022..
//

import UIKit

final class LoginViewController: BaseViewController<LoginViewModel> {
    private struct Constants {
        static let buttonCornerRadius: CGFloat = 10
        static let imageCornerRadius: CGFloat = 25
        static let contentCornerRadius: CGFloat = 35
        static let stackSpacingBig: CGFloat = 40
        static let forgotPassword = "Forgot password"
        static let loginButton = "Login"
        static let accountLabel = "Don't have an account?"
        static let registerLabel = "Register"
        static let emailLabel = "Email"
        static let emailPlaceholderLabel = "john.doe@mail.com"
        static let passwordLabel = "Password"
        static let passwordPlaceholderLabel = "******"
        static let repeatPasswordLabel = "Repeat password"
        static let repeatPasswordPlaceholderLabel = "******"
        static let forgotPasswordLabel = "Forgot password?"
    }
        
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "background_color")
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tab_bar_color")
        view.layer.cornerRadius = Constants.contentCornerRadius
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var inputContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.contentCornerRadius
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(named: "tab_bar_color")?.cgColor
        return view
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = Constants.stackSpacingBig
        return stack
    }()
    
    private lazy var emailTextField: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.setupWith(title: Constants.emailLabel,
                                placeholder: Constants.emailPlaceholderLabel,
                                image: getImage(isValid: false))
        textFieldView.textField.delegate = self
        return textFieldView
    }()
    
    private lazy var passwordTextField: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.setupWith(title: Constants.passwordLabel,
                                placeholder: Constants.passwordPlaceholderLabel,
                                image: getImage(isValid: false), secureText: true)
        textFieldView.textField.delegate = self
        return textFieldView
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.forgotPassword, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.loginButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.masksToBounds = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = Constants.accountLabel
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.registerLabel, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        addSubviews()
        makeConstraints()
    }
}

private extension LoginViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "tab_bar_color")
        navigationController?.navigationBar.isHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        inputStackView.setCustomSpacing(60, after: forgotPasswordButton)
        inputStackView.setCustomSpacing(60, after: loginButton)
        viewModel.onStateChange = setState
        
        viewModel.validateEmail(emailTextField.textField.text)
        viewModel.validatePassword(passwordTextField.textField.text)
    }
    
    func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)

        contentView.addSubview(inputContentView)
        inputContentView.addSubview(inputStackView)
        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordTextField)
        inputStackView.addArrangedSubview(forgotPasswordButton)
        inputStackView.addArrangedSubview(loginButton)
        inputStackView.addArrangedSubview(registerView)
        registerView.addSubview(accountLabel)
        registerView.addSubview(registerButton)
    }
    
    func makeConstraints() {
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(0)
            $0.height.equalTo(260)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(-250)
        }
        
        inputContentView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(0)
            $0.top.equalToSuperview().offset(40)
        }
        
        inputStackView.snp.makeConstraints {
            $0.top.equalTo(80)
            $0.leading.equalTo(25)
            $0.trailing.equalTo(-25)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalTo(0)
        }
        
        registerView.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
            $0.height.equalTo(30)
        }
        
        accountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-30)
        }
        
        registerButton.snp.makeConstraints {
            $0.centerY.equalTo(accountLabel.snp.centerY)
            $0.leading.equalTo(accountLabel.snp.trailing).offset(5)
        }
    }
    
    @objc func registerButtonTapped(_ sender: UITapGestureRecognizer) {
        viewModel.onDidTapRegister?()
    }
    
    @objc func loginButtonTapped(_ sender: UITapGestureRecognizer) {
        viewModel.loginUser(email: emailTextField.textField.text ?? "",
                            password: passwordTextField.textField.text ?? "") { [weak self] in
            self?.viewModel.onSuccessfullLogin?()
            self?.passwordTextField.textField.resignFirstResponder()
            self?.emailTextField.textField.resignFirstResponder()
        } onErrorCompletion: { [weak self] errorDescription in
            self?.viewModel.showAlert?("Error", errorDescription, "Confirm")
        }
    }
    
    @objc func forgotPasswordButtonTapped(_ sender: UITapGestureRecognizer) {
        viewModel.sendPasswordReset(withEmail: emailTextField.textField.text ?? "") { [weak self] error in
            if error == nil {
                self?.viewModel.showAlert?("Forgot Password Request",
                                           "Please check your email for further password restoration steps.",
                                           "Confirm")
            } else {
                self?.viewModel.showAlert?("Error", error?.localizedDescription, "Confirm")
            }
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        passwordTextField.textField.resignFirstResponder()
        emailTextField.textField.resignFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldInputValue = (string.isEmpty) ? String(textField.text?.dropLast() ?? "") : (textField.text ?? "") + string
        
        switch textField {
        case emailTextField.textField:
            viewModel.validateEmail(textFieldInputValue)
        case passwordTextField.textField:
            viewModel.validatePassword(textFieldInputValue)
        default:
            break
        }
        
        return true
    }
    
    func getImage(isValid: Bool) -> UIImage {
        isValid ? UIImage(named: "checkmark_circle")! : UIImage(named: "cross_circle")!
    }
    
    func setState(state: LogInState) {
        switch state {
        case .success:
            stopSpinner()
        case .failure(type: let type):
            stopSpinner()
            let title = "Error"
            let message: String?
            let actionTitle = "Confirm"
            
            switch type {
                case .invalidEmail:
                    message = type.errorDescription
                case .userDisabled:
                    message = type.errorDescription
                case .wrongPassword:
                    message = type.errorDescription
                case .unknown:
                    message = type.errorDescription
            }
            viewModel.showAlert?(title, message, actionTitle)
        
        case .idle(let isEmailValid, let isPasswordValid):
            stopSpinner()
            DispatchQueue.main.async { [weak self] in
                self?.emailTextField.setRightImage(self?.getImage(isValid: isEmailValid))
                self?.passwordTextField.setRightImage(self?.getImage(isValid: isPasswordValid))
            }
            loginButton.isEnabled = (isEmailValid && isPasswordValid)
            loginButton.backgroundColor = loginButton.isEnabled ? UIColor(named: "tab_bar_color") : UIColor(named: "tab_bar_color")?.withAlphaComponent(0.3)
        case .busy:
            startSpinner()
        }
    }
}
