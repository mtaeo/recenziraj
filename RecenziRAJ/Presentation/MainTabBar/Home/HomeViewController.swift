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
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var textView: UILabel = {
        let textView = UILabel()
        textView.text = "TextView test"
        textView.backgroundColor = .red
        return textView
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
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(textView)
        containerStackView.addArrangedSubview(takeImageButton)
        view.addSubview(containerStackView)
    }
    
    func makeConstraints() {
        containerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(300)
        }
        
        textView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    @objc func takeImageButtonTapped(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
}

extension HomeViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imageView.image = image
        
        if let image = image {
            viewModel.updateClassifications(for: image) { [weak self] classifications in
                if let classifications = classifications {
                    self?.viewModel.nicePrint(classifications)
                    self?.textView.text = "\(classifications.first?.identifier ?? "") ---> \(classifications.first?.confidence.rounded())"
                } else {
                    print("got nothing")
                }

            } errorHandler: { error in
                print(error.localizedDescription)
            }
        }
    }
    

    
}
