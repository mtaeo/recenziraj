//
//  ViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 27.08.2022..
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController<MainViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authService = AuthService()
        let registerViewModel = RegisterViewModel(authService: authService)
        let registerViewController = RegisterViewController(viewModel: registerViewModel)
        
        let loginViewModel = LoginViewModel(authService: authService)
        let loginViewController = LoginViewController(viewModel: loginViewModel)

        registerViewModel.onDidTapLogin = { [weak self] in
            self?.navigationController?.pushViewController(loginViewController, animated: true)
        }
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

