//
//  RegisterViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 27.08.2022..
//

import UIKit

final class RegisterViewController: BaseViewController<RegisterViewModel> {
    private struct Constants {
        static let buttonCornerRadius: CGFloat = 10
        static let imageCornerRadius: CGFloat = 25
        static let contentCornerRadius: CGFloat = 35
        static let stackSpacingBig: CGFloat = 40
        static let hStackSpacing: CGFloat = 20
        static let registerButton = "Register"
        static let orLabel = "Or"
        static let accountLabel = "Have an account already?"
        static let loginLabel = "Login"
        static let emailLabel = "Email"
        static let emailPlaceholderLabel = "john.doe@mail.com"
        static let passwordLabel = "Password"
        static let passwordPlaceholderLabel = "******"
        static let repeatPasswordLabel = "Repeat password"
        static let repeatPasswordPlaceholderLabel = "******"
    }
    
    var onSuccessfullRegistration: (() -> Void)?
    
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
    
    private lazy var emailTextField = TextFieldView()
    private lazy var passwordTextField = TextFieldView()
    private lazy var repeatPasswordTextField = TextFieldView()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.registerButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = .comicBold24
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .black.withAlphaComponent(0.2)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var orStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.hStackSpacing
        return stackView
    }()
    
    private lazy var lefttLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.orLabel
//        label.font = .comicRegular20
        label.textColor = .gray
        return label
    }()
    
    private lazy var rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
//        label.font = .comicRegular16
        label.textColor = .gray
        label.text = Constants.accountLabel
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
//        button.titleLabel?.font = .comicBold16
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.loginLabel, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        addSubviews()
        makeConstraints()
    }
}

private extension RegisterViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "tab_bar_color")
        navigationController?.navigationBar.isHidden = true

        inputContentView.layer.borderWidth = 5
        inputContentView.layer.borderColor = UIColor(named: "tab_bar_color")?.cgColor
        
        emailTextField.setupWith(title: Constants.emailLabel, placeholder: Constants.emailPlaceholderLabel, image: getImage(isValid: false))
        emailTextField.textField.delegate = self
        passwordTextField.setupWith(title: Constants.passwordLabel, placeholder: Constants.passwordPlaceholderLabel, image: getImage(isValid: false), secureText: true)
        passwordTextField.textField.delegate = self
        repeatPasswordTextField.setupWith(title: Constants.repeatPasswordLabel, placeholder: Constants.repeatPasswordPlaceholderLabel, image: getImage(isValid: false), secureText: true)
        repeatPasswordTextField.textField.delegate = self
        viewModel.onStateChange = setState
    }
    
    func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        
        contentView.addSubview(inputContentView)
        inputContentView.addSubview(inputStackView)
        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordTextField)
        inputStackView.addArrangedSubview(repeatPasswordTextField)
        inputStackView.addArrangedSubview(registerButton)
        inputStackView.addArrangedSubview(orStackView)
        orStackView.addArrangedSubview(lefttLine)
        orStackView.addArrangedSubview(orLabel)
        orStackView.addArrangedSubview(rightLine)
        inputStackView.addArrangedSubview(loginView)
        loginView.addSubview(accountLabel)
        loginView.addSubview(loginButton)
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
            $0.bottom.equalTo(-150)
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
        
        repeatPasswordTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
        }
        
        registerButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalTo(0)
        }
        
        orStackView.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
        
        lefttLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.trailing.equalTo(inputContentView.snp.centerX).offset(-30)
        }
        
        rightLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        loginView.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
            $0.height.equalTo(30)
        }
        
        accountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-30)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerY.equalTo(accountLabel.snp.centerY)
            $0.leading.equalTo(accountLabel.snp.trailing).offset(5)
        }
    }
    
    @objc func registerButtonTapped() {
        viewModel.registerUser(email: emailTextField.textField.text ?? "", password: passwordTextField.textField.text ?? "") { [weak self] in
            //
            self?.viewModel.onSuccessfullRegistration?()
        } onErrorCompletion: { errorDescription in
            print(errorDescription)
        }
        
    }
    
    @objc func loginButtonTapped() {
        viewModel.onDidTapLogin?()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldInputValue = (string.isEmpty) ? String(textField.text?.dropLast() ?? "") : (textField.text ?? "") + string
        
        switch textField {
            case emailTextField.textField:
                viewModel.validateEmail(email: textFieldInputValue)
            case passwordTextField.textField:
                viewModel.validatePassword(password: textFieldInputValue)
            case repeatPasswordTextField.textField:
                viewModel.validateRepeatPassword(password: passwordTextField.textField.text, repeatPassword: textFieldInputValue)
            default:
                break
        }
        
        return true
    }
    
    func getImage(isValid: Bool) -> UIImage {
        isValid ? UIImage(named: "checkmark_circle")! : UIImage(named: "cross_circle")!
    }
    
    func setState(state: State) {
        switch state {
        case .success:
            stopSpinner()
            
        case .failure(type: let type):
            stopSpinner()
            let message: String
            switch type {
            case .invalidEmail:
                message = type.localizedDescription
            case .emailAlreadyInUse:
                message = type.localizedDescription
            case .weakPassword:
                message = type.localizedDescription
            case .unknown:
                message = type.localizedDescription
            }
            viewModel.showAlertWithMessage?(message)
        
        case .idle(let isEmailValid, let isPasswordValid, let isRepeatPasswordValid):
            stopSpinner()
            DispatchQueue.main.async { [weak self] in
                self?.emailTextField.setRightImage(self?.getImage(isValid: isEmailValid))
                self?.passwordTextField.setRightImage(self?.getImage(isValid: isPasswordValid))
                self?.repeatPasswordTextField.setRightImage(self?.getImage(isValid: isRepeatPasswordValid))
            }
            registerButton.isEnabled = (isEmailValid && isPasswordValid && isRepeatPasswordValid)
            registerButton.backgroundColor = registerButton.isEnabled ? UIColor(named: "tab_bar_color") : UIColor(named: "tab_bar_color")?.withAlphaComponent(0.3)
        case .busy:
            startSpinner()
            print("Loading...")
        }
    }
}
