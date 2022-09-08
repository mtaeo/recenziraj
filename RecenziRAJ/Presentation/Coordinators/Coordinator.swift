//
//  Coordinator.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit

protocol Coordinator: NSObjectProtocol {
    var childCoordinators: [Coordinator] { get set }
    var shouldEnd: (() -> Void)? { get }
    
    func start()
}

extension Coordinator {
    func push(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    func pop(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
    func coordinatorShouldEnd() {
        shouldEnd?()
    }
}
