//
//  BaseCoordinator.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var navigationController = BaseNavigationController()
    private(set) var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func finish() {
        
    }
    
    func start(_ coordinator: Coordinator) {
        self.childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator}) {
            childCoordinators.remove(at: index)
        }else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
        
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
}

extension BaseCoordinator: Equatable {
    
    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
