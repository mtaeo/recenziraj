//
//  MainTabBarController.swift
//  RecenziRAJ
//
//  Created by Mateo on 06.09.2022..
//

import UIKit

final class MainTabBarController: UITabBarController {
    private struct Constants {
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 0.0
        static let topInset: CGFloat = 15
        static let horizontalInset: CGFloat = 0
        static let bottomInset: CGFloat = -10
        static let borderWidth: CGFloat = 0
    }
    
    private let viewModel: MainTabBarViewModel
    
    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
    }
}

private extension MainTabBarController {
    func setupSelf() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.isTranslucent = false
        tabBarAppearance.backgroundColor = .systemCyan
        tabBarAppearance.tintColor = .red
    
    }
}

extension MainTabBarController {
    func setupTabBarItemFor(_ viewController: UIViewController, image: UIImage) {
        viewController.tabBarItem.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.title = nil
    }
}
