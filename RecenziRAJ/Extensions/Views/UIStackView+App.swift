//
//  UIStackView+App.swift
//  RecenziRAJ
//
//  Created by Mateo on 02.02.2023..
//

import UIKit

extension UIStackView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { subview in
            addArrangedSubview(subview)
        }
    }
    
}
