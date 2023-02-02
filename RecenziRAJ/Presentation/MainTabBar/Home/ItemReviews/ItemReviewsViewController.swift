//
//  ItemReviewsViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//
import UIKit
import SnapKit
import FirebaseStorageUI

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
    
    private lazy var addReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Review", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "tab_bar_color")
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addReviewButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var itemReviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = UIColor(named: "background_color")
        tableView.bounces = true
        tableView.isHidden = true
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
    
    override func viewDidLayoutSubviews() {
        startSpinner()
        viewModel.fetchItemReviews { [weak self] itemReviews, error in
            self?.itemReviewsTableView.isHidden = false
            self?.itemReviewsTableView.reloadData()
            self?.stopSpinner()
        }
    }


}

private extension ItemReviewsViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {
        itemContainerStackView.addArrangedSubview(itemImageView)
        innerRightItemContainerStackView.addArrangedSubview(itemNameLabel)
        innerRightItemContainerStackView.addArrangedSubview(itemRatingLabel)
        innerRightItemContainerStackView.addArrangedSubview(addReviewButton)
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
    
        addReviewButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        itemContainerStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        itemReviewsTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

    }
    
    @objc func addReviewButtonTapped(_ sender: UIButton) {
        viewModel.onDidTapAddReview?()
    }
}

extension ItemReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemsCount = viewModel.getItemReviewsTableRowsCount()

        itemsCount == 0
        ? itemReviewsTableView.setEmptyMessage("No reviews for this product as of yet.")
        : itemReviewsTableView.restore()
        
        return itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemReviewTableViewCell.cellIdentifier, for: indexPath) as? ItemReviewTableViewCell else {
            return ItemReviewTableViewCell()
        }
        let itemReview = viewModel.getItemReview(at: indexPath.row)
        cell.setup(itemReview: itemReview)
        cell.profileImageView.sd_setImage(with: viewModel.storageService.profileImagesStorageRef.child(itemReview?.userUid ?? ""),
                                          placeholderImage: UIImage(named: "profile_image_placholder"))
        return cell
    }
}
