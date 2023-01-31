//
//  UITableView+App.swift
//  RecenziRAJ
//
//  Created by Mateo on 31.01.2023..
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let label = UILabel(frame:
                                CGRect(x: 0,
                                       y: 0,
                                       width: bounds.size.width,
                                       height: bounds.size.height))
        label.text = message
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        backgroundView = label
        separatorStyle = .none
    }

    func restore() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
