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
        
        let mainTabBarViewModel = MainTabBarViewModel(authService: authService)
        let mainTabBarController = MainTabBarController(viewModel: mainTabBarViewModel)

        registerViewModel.onDidTapLogin = { [weak self] in
            self?.navigationController?.pushViewController(loginViewController, animated: true)
        }
        
        registerViewController.onSuccessfullRegistration = { [weak self] in
            guard let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first else { return }
            
            window.rootViewController = mainTabBarController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft],
                              animations: nil,
                              completion: nil)
        }
        
        navigationController?.setViewControllers([registerViewController], animated: true)
    }
}

