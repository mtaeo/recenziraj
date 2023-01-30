//
//  AddReviewViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 30.01.2023..
//

import UIKit
import SnapKit

final class AddReviewViewController: BaseViewController<AddReviewViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        addSubviews()
        makeConstraints()
    }


}

private extension AddReviewViewController {
    func setupSelf() {
        view.backgroundColor = .yellow
    }
    
    func addSubviews() {
        
    }
    
    func makeConstraints() {

    }
    
    @objc func submitReviewButtonTapped(_ sender: UIButton) {
        print("submit review")
    }
}
