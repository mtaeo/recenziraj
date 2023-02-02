//
//  TextFieldView.swift
//  RecenziRAJ
//
//  Created by Mateo on 27.08.2022..
//

import UIKit

final class TextFieldView: UIView {
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.resignFirstResponder()
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
        textField.rightViewMode = .always
        textField.clearButtonMode = .always
        textField.textColor = .black
        return textField
    }()
        
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TextFieldView {
    func addSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(textField)
    }
    
    func makeConstraints() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalTo(0)
            $0.height.equalTo(40)
        }
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(25)
        }
        
    }
}

extension TextFieldView {
    func setupWith(title: String, placeholder: String, image: UIImage? = nil, secureText: Bool = false) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.isSecureTextEntry = secureText
        textField.rightView = iconImageView
        iconImageView.image = image
    }
    
    func setRightImage(_ image: UIImage?) {
        iconImageView.image = image
    }
}
