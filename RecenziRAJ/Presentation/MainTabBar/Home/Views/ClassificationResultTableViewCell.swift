//
//  ClassificationResultTableViewCell.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import UIKit
import SnapKit

final class ClassificationResultTableViewCell: UITableViewCell {

    static let cellIdentifier = "ClassificationResultTableViewCell"
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        return imageView
    }()
    
    private lazy var innerRightContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    private lazy var itemRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.3/5"
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
}


extension ClassificationResultTableViewCell {
    
    func setup(image: UIImage?, title: String?, percentage: Float) {
        itemImageView.image = image
        itemTitleLabel.text = title
        itemRatingLabel.text = "\(percentage) %"
    }
    
}

private extension ClassificationResultTableViewCell {
    func setupSelf() {

    }
    
    func addSubviews() {
        innerRightContainerStackView.addArrangedSubview(itemTitleLabel)
        innerRightContainerStackView.addArrangedSubview(itemRatingLabel)
        containerStackView.addArrangedSubview(itemImageView)
        containerStackView.addArrangedSubview(innerRightContainerStackView)
        contentView.addSubview(containerStackView)
    }
    
    func makeConstraints() {
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itemImageView.snp.makeConstraints {
            $0.size.equalTo(50)
        }
    }
}
