//
//  ItemReviewTableViewCell.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import UIKit

final class ItemReviewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ItemReviewTableViewCell"

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

extension ItemReviewTableViewCell {
    
    func setup() {
        
    }
    
}

private extension ItemReviewTableViewCell {
    func setupSelf() {
        contentView.backgroundColor = UIColor(named: "background_color")
    }
    
    func addSubviews() {

    }
    
    func makeConstraints() {

    }
}
