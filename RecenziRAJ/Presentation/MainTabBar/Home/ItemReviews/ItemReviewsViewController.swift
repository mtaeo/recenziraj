//
//  ItemReviewsViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import UIKit
import SnapKit

final class ItemReviewsViewController: BaseViewController<ItemReviewsViewModel> {
    
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

    private lazy var itemReviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = UIColor(named: "background_color")
        tableView.bounces = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(ItemReviewTableViewCell.self, forCellReuseIdentifier: ItemReviewTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        addSubviews()
        makeConstraints()
    }


}

private extension ItemReviewsViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {
        innerRightItemContainerStackView.addArrangedSubview(itemNameLabel)
        innerRightItemContainerStackView.addArrangedSubview(itemRatingLabel)
        containerStackView.addArrangedSubview(innerRightItemContainerStackView)
        itemContainerStackView.addArrangedSubview(itemImageView)
        itemContainerStackView.addArrangedSubview(innerRightItemContainerStackView)
        containerStackView.addArrangedSubview(itemContainerStackView)
        containerStackView.addArrangedSubview(itemReviewsTableView)

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
            $0.trailing.equalToSuperview()
        }
        
        itemReviewsTableView.snp.makeConstraints {
//            $0.top.equalTo(itemContainerStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ItemReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemReviewTableViewCell.cellIdentifier, for: indexPath) as? ItemReviewTableViewCell else {
            return ItemReviewTableViewCell()
        }
        return cell
    }
}
