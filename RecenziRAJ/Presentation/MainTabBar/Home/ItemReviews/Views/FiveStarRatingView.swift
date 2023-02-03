//
//  FiveStarRatingView.swift
//  RecenziRAJ
//
//  Created by Mateo on 02.02.2023..
//

import UIKit

final class FiveStarRatingView: UIView {
    
    var onValueChange: ((Int) -> Void)?
    
    var ratingValue: Int = 0 {
        didSet {
            processNewRating()
        }
    }
    
    private let minRatingValue = 1
    private let maxRatingValue = 5
    private var starSize: Int?
    
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    private lazy var starButtons: [UIButton] = generateStarButtons(max: maxRatingValue)

    init(starSize: Int, isUserInteractionEnabled: Bool = false) {
        super.init(frame: CGRect.zero)
        
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.starSize = starSize
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FiveStarRatingView {
    func addSubviews() {
        contentStackView.addArrangedSubviews(starButtons)
        addSubview(contentStackView)
    }
    
    func makeConstraints() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentStackView.arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else {
                return
            }
            button.imageView?.snp.makeConstraints {
                $0.size.equalTo(starSize ?? 25)
            }
        }
    }
    
    func generateStarButtons(max: Int) -> [UIButton] {
        var buttons: [UIButton] = []
        
        for i in 0...(max - 1) {
            let button = UIButton()
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.tag = i + 1
            button.addTarget(self,
                             action: #selector(starButtonTap),
                             for: .touchUpInside)
            button.tintColor = .gray
            buttons.append(button)
        }
        return buttons
    }
    
    func processNewRating() {
        resetStars()
        var counter: Int = 0
        for i in (0...(maxRatingValue - 1)) {
            if counter == ratingValue {
                break
            }
            starButtons[i].tintColor = UIColor(named: "border_color")
            starButtons[i].setImage(UIImage(systemName: "star.fill"), for: .normal)
            counter += 1
        }
    }
    
    func resetStars() {
        starButtons.forEach { button in
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.tintColor = .gray
        }
    }
    
    @objc func starButtonTap(_ sender: UIButton) {
        ratingValue = sender.tag
        onValueChange?(ratingValue)
    }
}
