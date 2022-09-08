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
    
    init(navigationController: UINavigationController, authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    func start() {
        setViewController()
    }
}

private extension ProfileCoordinator {
    func setViewController() {
        let profileViewModel = ProfileViewModel(authService: authService)
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        
        profileViewModel.onLogoutButtonPressed = {
            self.authService.logoutUser()
            self.dismissNavigationController()
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
