//
//  HomeViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var introductionLabel: UILabel = {
        let label = UILabel()
        label.text = "Take a picture of a product you want to see reviews for"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var takeImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill")?.withTintColor(.darkGray, renderingMode: UIImage.RenderingMode.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(takeImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        imageView.isMultipleTouchEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takeImageButtonTapped)))
        return imageView
    }()
    
    private lazy var classificationResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "background_color")
        tableView.bounces = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(ClassificationResultTableViewCell.self, forCellReuseIdentifier: ClassificationResultTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
        addSubviews()
        makeConstraints()
    }
}

private extension HomeViewController {
    func setupSelf() {
        view.backgroundColor = UIColor(named: "background_color")
        navigationController?.navigationBar.topItem?.title = "RecenziRAJ"
    }
    
    func addSubviews() {
        containerStackView.addArrangedSubview(introductionLabel)
        containerStackView.addArrangedSubview(takeImageButton)
        containerStackView.addArrangedSubview(itemImageView)
        view.addSubview(containerStackView)
        view.addSubview(classificationResultTableView)
    }
    
    func makeConstraints() {
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        takeImageButton.snp.makeConstraints {
            $0.size.equalTo(75)
        }
        
        takeImageButton.imageView?.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(75)
        }
        
        itemImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.lessThanOrEqualTo(75)
            $0.centerX.equalToSuperview()
        }
        
        classificationResultTableView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc func takeImageButtonTapped(_ sender: UIView) {
        imagePicker.present(from: sender)
    }
}

extension HomeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        startSpinner()
        itemImageView.image = image
        
        if let image = image {
            itemImageView.isHidden = false
            classificationResultTableView.isHidden = false
            viewModel.updateClassifications(for: image) { [weak self] classifications in
                if classifications != nil {
                    self?.classificationResultTableView.reloadData()
                }
                self?.stopSpinner()
            } errorHandler: { [weak self] error in
                self?.viewModel.showAlert?("Error",
                                           "There was an unknown error while trying to classify your image.",
                                           "Confirm")
                self?.stopSpinner()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassificationResultTableViewCell.cellIdentifier, for: indexPath) as? ClassificationResultTableViewCell else { return UITableViewCell() }
        cell.setup(image: UIImage(named: viewModel.getClassificationItemThumbnailName(indexPath.row)),
                   title: viewModel.getClassificationItemName(indexPath.row),
                   percentage: viewModel.getClassificationItemPercentage(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapClassificationItem(index: indexPath.row)
    }
}
