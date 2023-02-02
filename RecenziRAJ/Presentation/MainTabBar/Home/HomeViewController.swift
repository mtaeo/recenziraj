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
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.contentMode = .scaleToFill
        button.setImage(UIImage(systemName: "camera.fill")?.withTintColor(.darkGray, renderingMode: UIImage.RenderingMode.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(takeImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = nil
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
        view.addSubview(introductionLabel)
        view.addSubview(takeImageButton)
        view.addSubview(itemImageView)
        view.addSubview(classificationResultTableView)
        
    }
    
    func makeConstraints() {
        introductionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        takeImageButton.snp.makeConstraints {
            $0.top.equalTo(introductionLabel.snp.bottom).offset(10)
            $0.height.equalTo(75)
            $0.width.equalTo(125)
            $0.centerX.equalToSuperview()
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.equalTo(takeImageButton.snp.bottomMargin)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        
        classificationResultTableView.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom)
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
            viewModel.updateClassifications(for: image) { [weak self] classifications in
                let x = self?.viewModel.afterImage
                if classifications != nil {
                    self?.classificationResultTableView.isHidden = false
                    self?.classificationResultTableView.reloadData()
                }
                self?.view.layoutIfNeeded()
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
