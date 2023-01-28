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
        button.setTitleColor(.systemRed, for: .normal)
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
        logoutButton.backgroundColor = .yellow
    }
    
    func makeConstraints() {
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(150)
        }
    }
    
    @objc func logoutButtonTapped() {
        logoutConfirmationAlert()
    }
    
    func logoutConfirmationAlert() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout out of this account?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes, Logout", style: .destructive, handler: { [weak self] (action) in
            self?.viewModel.onLogoutButtonPressed?()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
