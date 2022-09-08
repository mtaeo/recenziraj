//
//  ProfileViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        addSubviews()
        makeConstraints()
    }
}

private extension ProfileViewController {
    func setupSelf() {
        view.backgroundColor = .gray
    }
    
    func addSubviews() {
        view.addSubview(logoutButton)
    }
    
    func makeConstraints() {
        logoutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func logoutButtonTapped() {
        viewModel.onLogoutButtonPressed?()
    }
}
