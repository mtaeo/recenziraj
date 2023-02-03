//
//  AddReviewViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 30.01.2023..
//

import UIKit
import SnapKit

final class AddReviewViewController: BaseViewController<AddReviewViewModel> {
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: viewModel.itemNameEnum.thumbnail)
        return imageView
    }()

    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.itemNameEnum.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var itemRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starRatingView: FiveStarRatingView = {
        let view = FiveStarRatingView(starSize: 40)
        view.onValueChange = { [weak self] value in
            self?.viewModel.starRating = value
            let canSubmitReview = self?.viewModel.isStarRatingSet() ?? false
            self?.submitReviewButton.isEnabled = canSubmitReview
            self?.submitReviewButton.backgroundColor = canSubmitReview ? .black : .black.withAlphaComponent(0.3)
        }
        return view
    }()
    
    private lazy var reviewTextFieldView: TextFieldView = {
        let textFieldView = TextFieldView()
        textFieldView.setupWith(title: "Review", placeholder: "")
        textFieldView.textField.backgroundColor = UIColor(named: "background_color")

        return textFieldView
    }()
    
    private lazy var submitReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit Review", for: .normal)
        button.addTarget(self,
                         action: #selector(submitReviewButtonTapped),
                         for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        addSubviews()
        makeConstraints()
    }
}

private extension AddReviewViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {
        view.addSubview(itemImageView)
        view.addSubview(itemNameLabel)
        view.addSubview(itemRatingLabel)
        view.addSubview(starRatingView)
        view.addSubview(reviewTextFieldView)
        view.addSubview(submitReviewButton)
    }
    
    func makeConstraints() {
        itemImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.size.equalTo(150)
        }
        
        itemNameLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(20)
            $0.top.equalTo(itemImageView.snp.top)
            $0.trailing.equalToSuperview().offset(20)
        }
        
        itemRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(20)
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(20)
            $0.trailing.equalTo(itemNameLabel.snp.trailing).offset(20)
        }
        
        starRatingView.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        reviewTextFieldView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(starRatingView.snp.bottom).offset(20)
            $0.height.equalTo(75)
        }
        
        submitReviewButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(reviewTextFieldView.snp.bottom).offset(20)
            $0.height.equalTo(60)
        }
    }
    
    @objc func submitReviewButtonTapped(_ sender: UIButton) {
        guard let review = reviewTextFieldView.textField.text else {
            return
        }
        viewModel.submitReview(review: review, starRating: viewModel.starRating) { [weak self] error in
            if error != nil {
                self?.viewModel.showAlert?("Error",
                                           "There was an error while trying to submit your review.",
                                           "Confirm")
            } else {
                self?.viewModel.popVC?()
            }
        }
    }
}
