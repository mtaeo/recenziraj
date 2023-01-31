//
//  ItemReviewTableViewCell.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import UIKit

final class ItemReviewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ItemReviewTableViewCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder_profile_image")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor(named: "border_color")?.cgColor
        return imageView
    }()
    
    private lazy var reviewContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var userDisplayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Placeholder"
        return label
    }()
    
    private lazy var starAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "4/5"
        return label
    }()
    
    private lazy var itemReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Review placeholder"
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false
        profileImageView.image = UIImage(named: "placeholder_profile_image")
    }

}

extension ItemReviewTableViewCell {
    
    func setup(itemReview: ItemReview?) {
        userDisplayNameLabel.text = itemReview?.userDisplayName ?? "Anonymous"
        itemReviewLabel.text = itemReview?.review
    }
    
    func setupImageWithData(_ reviewerProfileImageData: Data?) {
        if let data = reviewerProfileImageData {
            profileImageView.image = UIImage(data: data)
        } else {
            profileImageView.image = UIImage(named: "placeholder_profile_image")
        }
    }
    
}

private extension ItemReviewTableViewCell {
    func setupSelf() {
        contentView.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {
        reviewContainerStackView.addArrangedSubview(userDisplayNameLabel)
        reviewContainerStackView.addArrangedSubview(starAmountLabel)
        reviewContainerStackView.addArrangedSubview(itemReviewLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(reviewContainerStackView)
    }
    
    func makeConstraints() {
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        reviewContainerStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        userDisplayNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        itemReviewLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        starAmountLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
    }
}
