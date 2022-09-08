//
//  MainCoordinator.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit
import SnapKit

final class MainCoordinator: NSObject, Coordinator {
    var shouldEnd: (() -> Void)?
    var childCoordinators: [Coordinator]
    
    private var viewController: UIViewController
    private var mainTabBarViewController: MainTabBarController?
    private let authService = AuthService()
    
    init(viewController: UIViewController) {
        childCoordinators = [Coordinator]()
        self.viewController = viewController
    }
    
    func start() {
        showAuth(in: viewController)
    }
}

private extension MainCoordinator {
    func showAuth(in viewController: UIViewController) {
        let navigationController = UINavigationController()
        viewController.attachChildVC(navigationController)
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                              authService: authService)
        
        authCoordinator.shouldEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.showTabBar(in: viewController)
                self?.pop(authCoordinator)
            }
        }
        
        push(authCoordinator)
    }
    
    func showTabBar(in viewController: UIViewController) {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController, authService: authService)
        push(homeCoordinator)
        setupTabBarItemFor(homeNavigationController, image: UIImage(systemName: "house")!)

        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController, authService: authService)
        push(profileCoordinator)
        setupTabBarItemFor(profileNavigationController, image: UIImage(systemName: "person.circle")!)
        
        let mainTabBarViewModel = MainTabBarViewModel(authService: authService)
        let mainTabBarViewController = MainTabBarController(viewModel: mainTabBarViewModel)
        mainTabBarViewController.setViewControllers([homeNavigationController, profileNavigationController], animated: false)
        viewController.attachChildVC(mainTabBarViewController)
        
        profileCoordinator.shouldEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.showAuth(in: viewController)
                self?.pop(profileCoordinator)
                self?.pop(homeCoordinator)
            }
        }
    }

    func setupTabBarItemFor(_ viewController: UIViewController, image: UIImage) {
        viewController.tabBarItem.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
}

