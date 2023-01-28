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
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.text = "RecenziRAJ"
        label.font = UIFont.systemFont(ofSize: 48)
        label.backgroundColor = .red
        return label
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private lazy var sublineLabel: UILabel = {
        let label = UILabel()
        label.text = "Take a picture of a product you want to see reviews for"
        label.font = UIFont.systemFont(ofSize: 28)
        label.numberOfLines = 0
        label.backgroundColor = .systemYellow
        return label
    }()
    
    private lazy var classificationResultLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        return label
    }()

    private lazy var takeImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.addTarget(self, action: #selector(takeImageButtonTapped), for: .touchUpInside)
        return button
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
    }
    
    func addSubviews() {
        containerStackView.addArrangedSubview(headlineLabel)
        containerStackView.addArrangedSubview(itemImageView)
        containerStackView.addArrangedSubview(sublineLabel)
        containerStackView.addArrangedSubview(takeImageButton)
        view.addSubview(containerStackView)
    }
    
    func makeConstraints() {
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        itemImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        headlineLabel.snp.makeConstraints {
//            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        takeImageButton.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalToSuperview()
        }
        
    }
    
    @objc func takeImageButtonTapped(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
}

extension HomeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        itemImageView.image = image
        
        if let image = image {
            viewModel.updateClassifications(for: image) { [weak self] classifications in
                if let classifications = classifications {
                    self?.viewModel.nicePrint(classifications)
                    self?.classificationResultLabel.text = "\(classifications.first?.identifier ?? "") ---> \(classifications.first?.confidence.rounded())"
                } else {
                    self?.classificationResultLabel.text = "Nothing?"
                    print("got nothing")
                }

            } errorHandler: { error in
                print(error.localizedDescription)
            }
        }
    }
    

    
}
