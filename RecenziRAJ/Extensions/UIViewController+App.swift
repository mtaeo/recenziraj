//
//  UIViewController+App.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

extension UIViewController {
    func attachChildVC(_ childVC: UIViewController) {
        addChild(childVC)
        childVC.didMove(toParent: self)
        view.addSubview(childVC.view)
        childVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func removeChildViewControllers() {
      children.forEach {
        $0.willMove(toParent: nil)
        $0.view.removeFromSuperview()
        $0.removeFromParent()
      }
    }
}
