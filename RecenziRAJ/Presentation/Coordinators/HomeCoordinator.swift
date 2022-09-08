//
//  HomeCoordinator.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class HomeCoordinator: NSObject, Coordinator {
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

private extension HomeCoordinator {
    func setViewController() {
        let homeViewModel = HomeViewModel(authService: authService)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
