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
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var innerRightContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var itemPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0 %"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
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
    
    func setup(image: UIImage?, title: String?, percentage: String?) {
        itemImageView.image = image
        itemTitleLabel.text = title
        itemPercentageLabel.text = percentage
    }
    
}

private extension ClassificationResultTableViewCell {
    func setupSelf() {
        contentView.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {
        innerRightContainerStackView.addArrangedSubview(itemTitleLabel)
        innerRightContainerStackView.addArrangedSubview(itemPercentageLabel)
        containerStackView.addArrangedSubview(itemImageView)
        containerStackView.addArrangedSubview(innerRightContainerStackView)
        contentView.addSubview(containerStackView)
    }
    
    func makeConstraints() {
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itemImageView.snp.makeConstraints {
            $0.size.equalTo(75)
            $0.leading.equalTo(containerStackView.snp.leading).inset(10)
            $0.top.equalTo(containerStackView.snp.top).inset(10)
            $0.bottom.equalTo(containerStackView.snp.bottom).inset(10)
        }
    }
}
