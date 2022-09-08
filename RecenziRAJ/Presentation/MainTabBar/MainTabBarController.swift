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
        static let borderWidth: CGFloat = 0
    }
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(.checkmark, for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = Constants.shadowOpacity
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.masksToBounds = false
        return button
    }()
    
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
        setupTabBarItems()
        addSubviews()
        makeConstraints()
    }
}

private extension MainTabBarController {
    func setupSelf() {
        view.backgroundColor = .yellow
        UITabBar.appearance().barTintColor = .yellow
        UITabBar.appearance().layer.borderWidth = Constants.borderWidth
        UITabBar.appearance().clipsToBounds = true
        tabBar.isTranslucent = false
    }
    
    func setupTabBarItems() {
        //
    }
    
    func addSubviews() {
        tabBar.addSubview(addButton)
    }
    
    func makeConstraints() {
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(0)
        }
    }
}
