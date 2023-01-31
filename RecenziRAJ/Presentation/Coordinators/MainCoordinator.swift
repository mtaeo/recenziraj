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
    private let userInteractionsService = UserInteractionsService()
    private let storageService = StorageService()
    
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
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController,
                                              userInteractionsService: userInteractionsService,
                                              storageService: storageService,
                                              authService: authService)
        push(homeCoordinator)
        setupTabBarItemFor(homeNavigationController, image: UIImage(systemName: "house")!, title: "Home")

        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController,
                                                    authService: authService,
                                                    storageService: storageService)
        push(profileCoordinator)
        setupTabBarItemFor(profileNavigationController, image: UIImage(systemName: "person.circle")!, title: "Profile")
        
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

    func setupTabBarItemFor(_ viewController: UIViewController, image: UIImage, title: String? = nil) {
        viewController.tabBarItem.image = image.withTintColor(.lightGray, renderingMode: UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.selectedImage = image.withTintColor(.white, renderingMode: UIImage.RenderingMode.alwaysOriginal)
        viewController.title = title
    }
}

