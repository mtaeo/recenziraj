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
    private let userInteractionsService: UserInteractionsService
    private let storageService: StorageService
        
    init(navigationController: UINavigationController,
         userInteractionsService: UserInteractionsService,
         storageService: StorageService,
         authService: AuthService) {
        self.navigationController = navigationController
        self.authService = authService
        self.storageService = storageService
        self.userInteractionsService = userInteractionsService
    }
    
    func start() {
        setViewController()
    }
}

private extension HomeCoordinator {
    func setViewController() {
        let homeViewModel = HomeViewModel(authService: authService)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        homeViewModel.onDidTapClassificationItem = { itemNameEnum in
            self.presentItemReviewsViewController(itemNameEnum)
        }
        
        homeViewModel.showAlert = { title, message, actionTitle in
            if homeViewController.presentedViewController == nil {
                homeViewController.present(self.showAlert(title: title, message: message, actionTitle: actionTitle), animated: true, completion: nil)
            }
        }
        
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func presentItemReviewsViewController(_ itemNameEnum: Classifications.ItemName) {
        let itemReviewsViewModel = ItemReviewsViewModel(authService: authService,
                                                        userInteractionsService: userInteractionsService,
                                                        storageService: storageService,
                                                        itemNameEnum: itemNameEnum)
        let itemReviewsViewController = ItemReviewsViewController(viewModel: itemReviewsViewModel)
        
        itemReviewsViewModel.showAlert = { title, message, actionTitle in
            if itemReviewsViewController.presentedViewController == nil {
                itemReviewsViewController.present(self.showAlert(title: title, message: message, actionTitle: actionTitle), animated: true, completion: nil)
            }
        }
        
        itemReviewsViewModel.onDidTapAddReview = {
            self.presentAddReviewViewController(itemReviewsViewModel.itemNameEnum)
        }
        
        navigationController.pushViewController(itemReviewsViewController, animated: true)
    }
    
    func presentAddReviewViewController(_ itemNameEnum: Classifications.ItemName) {
        let addReviewViewModel = AddReviewViewModel(authService: authService,
                                                    userInteractionsService: userInteractionsService,
                                                    itemNameEnum: itemNameEnum)
        let addReviewViewController = AddReviewViewController(viewModel: addReviewViewModel)
        
        addReviewViewModel.showAlert = { title, message, actionTitle in
            if addReviewViewController.presentedViewController == nil {
                addReviewViewController.present(self.showAlert(title: title, message: message, actionTitle: actionTitle), animated: true, completion: nil)
            }
        }
        
        navigationController.pushViewController(addReviewViewController, animated: true)
    }
}
