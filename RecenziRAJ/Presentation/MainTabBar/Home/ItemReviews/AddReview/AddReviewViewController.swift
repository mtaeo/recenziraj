//
//  AddReviewViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 30.01.2023..
//

import UIKit
import SnapKit

final class AddReviewViewController: BaseViewController<AddReviewViewModel> {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var itemContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 20
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return stackView
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: viewModel.itemNameEnum.thumbnail)
        return imageView
    }()
    
    private lazy var innerRightItemContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
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
        label.text = "4.3/5"
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
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
        button.addTarget(self, action: #selector(submitReviewButtonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
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
        itemContainerStackView.addArrangedSubview(itemImageView)
        innerRightItemContainerStackView.addArrangedSubview(itemNameLabel)
        innerRightItemContainerStackView.addArrangedSubview(itemRatingLabel)
        itemContainerStackView.addArrangedSubview(innerRightItemContainerStackView)
        containerStackView.addArrangedSubview(itemContainerStackView)
        containerStackView.addArrangedSubview(reviewTextFieldView)
        containerStackView.addArrangedSubview(submitReviewButton)

        view.addSubview(containerStackView)
    }
    
    func makeConstraints() {
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        itemImageView.snp.makeConstraints {
            $0.size.equalTo(150)
        }

        itemContainerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(175)
        }
        
        reviewTextFieldView.snp.makeConstraints {
            $0.top.equalTo(itemContainerStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(75)
        }
        
        submitReviewButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(200)
            $0.height.equalTo(50)
        }
    }
    
    @objc func submitReviewButtonTapped(_ sender: UIButton) {
        guard let review = reviewTextFieldView.textField.text else {
            return
        }
        viewModel.submitReview(review: review) { [weak self] error in
            if let error = error {
                self?.viewModel.showAlert?("Error", "There was an error while trying to submit your review.", "Confirm")
            } else {
                self?.viewModel.showAlert?("Success", "Your review has been successfully submitted.", "Confirm")
            }
        }
    }
}
