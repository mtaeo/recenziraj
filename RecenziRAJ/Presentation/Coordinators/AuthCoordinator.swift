//
//  AuthCoordinator.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class AuthCoordinator: NSObject, Coordinator {
    var shouldEnd: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController
    private let authService: AuthService
        
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    func start() {
        setLogInViewController()
    }
}

private extension AuthCoordinator {
    func setLogInViewController() {
        let loginViewModel = LoginViewModel(authService: authService)
        let loginViewController = LoginViewController(viewModel: loginViewModel)

        loginViewModel.onDidTapRegister = {
            self.presentRegisterViewController()
        }
        
        loginViewModel.onSuccessfullLogin = { [unowned self] in
            self.dismissNavigationController()
        }
        
        loginViewModel.showAlert = { [unowned self] title, message, actionTitle in
            if loginViewController.presentedViewController == nil {
                loginViewController.present(self.showAlert(title: title, message: message, actionTitle: actionTitle), animated: true, completion: nil)
            }
        }
        
        navigationController.setViewControllers([loginViewController], animated: false)
    }
    
    func presentRegisterViewController() {
        let registerViewModel = RegisterViewModel(authService: authService)
        let registerViewController = RegisterViewController(viewModel: registerViewModel)
        
        registerViewModel.onDidTapLogin = {
            self.navigationController.popViewController(animated: true)
        }

        registerViewModel.onSuccessfullRegistration = { [unowned self] in
            self.dismissNavigationController()
        }
        
        registerViewModel.showAlert = { title, message, actionTitle in
            if registerViewController.presentedViewController == nil {
                registerViewController.present(self.showAlert(title: title, message: message, actionTitle: actionTitle), animated: true, completion: nil)
            }
        }
        
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func dismissNavigationController() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.dismiss(animated: true, completion: nil)
            self?.navigationController.removeFromParent()
            self?.coordinatorShouldEnd()
        }
    }
}
