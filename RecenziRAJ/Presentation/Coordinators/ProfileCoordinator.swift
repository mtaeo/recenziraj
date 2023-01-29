//
//  ProfileCoordinator.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class ProfileCoordinator: NSObject, Coordinator {
    var shouldEnd: (() -> Void)?
    var childCoordinators = [Coordinator]()
    
    private var navigationController: UINavigationController
    private let authService: AuthService
    private let storageService: StorageService
    
    init(navigationController: UINavigationController, authService: AuthService, storageService: StorageService) {
        self.navigationController = navigationController
        self.authService = authService
        self.storageService = storageService
    }
    
    func start() {
        setViewController()
    }
}

private extension ProfileCoordinator {
    func setViewController() {
        let profileViewModel = ProfileViewModel(authService: authService, storageService: storageService)
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        
        profileViewModel.onLogoutButtonPressed = {
            self.authService.logoutUser()
            self.dismissNavigationController()
        }
        
        profileViewModel.showAlert = { [unowned self] title, message, actionTitle in
            if profileViewController.presentedViewController == nil {
                profileViewController.present(self.showAlert(title: title, message: message, actionTitle: actionTitle), animated: true, completion: nil)
            }
        }
        
        navigationController.setViewControllers([profileViewController], animated: false)
    }
    
    func dismissNavigationController() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.dismiss(animated: true, completion: nil)
            self?.navigationController.removeFromParent()
            self?.coordinatorShouldEnd()
        }
    }
}
