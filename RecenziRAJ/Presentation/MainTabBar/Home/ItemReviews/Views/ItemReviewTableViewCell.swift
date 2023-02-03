//
//  ItemReviewTableViewCell.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import UIKit

final class ItemReviewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ItemReviewTableViewCell"
    
     lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder_profile_image")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "border_color")?.cgColor
        return imageView
    }()
    
    private lazy var reviewContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        return stackView
    }()
    
    private lazy var userDisplayNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starAmountView: FiveStarRatingView = {
        let starAmountView = FiveStarRatingView(starSize: 20)
        starAmountView.setContentCompressionResistancePriority(.required, for: .vertical)
        return starAmountView
    }()
    
    private lazy var itemReviewLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSelf()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }

}

extension ItemReviewTableViewCell {
    
    func setup(itemReview: ItemReview?) {
        userDisplayNameLabel.text = itemReview?.userDisplayName ?? "Anonymous"
        itemReviewLabel.text = itemReview?.review
        starAmountView.ratingValue = itemReview?.starAmount ?? 1
    }
    
    func setupImageWithData(_ reviewerProfileImageData: Data?) {
        if let data = reviewerProfileImageData {
            profileImageView.image = UIImage(data: data)
        } else {
            profileImageView.image = UIImage(named: "placeholder_profile_image")
        }
        setNeedsLayout()
    }
    
}

private extension ItemReviewTableViewCell {
    func setupSelf() {
        contentView.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(userDisplayNameLabel)
        contentView.addSubview(starAmountView)
        contentView.addSubview(itemReviewLabel)
    }
    
    func makeConstraints() {
        
        profileImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
            $0.size.equalTo(50)
        }
        
        userDisplayNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.trailing.equalToSuperview().inset(10)
        }
        
        starAmountView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(userDisplayNameLabel.snp.bottom).offset(10)
        }
        
        itemReviewLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(starAmountView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
    }
}
