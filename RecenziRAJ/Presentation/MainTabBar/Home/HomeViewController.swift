//
//  HomeViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        addSubviews()
        makeConstraints()
    }
}

private extension HomeViewController {
    func setupSelf() {
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        
    }
    
    func makeConstraints() {
        
    }
}
