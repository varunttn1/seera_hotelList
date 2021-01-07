//
//  Coordinator.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var navigationController: BaseNavigationController { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func finish()
    
    func start(_ coordinator: Coordinator)

       func removeChildCoordinator(_ coordinator: Coordinator)
       
       func removeAllChildCoordinatorsWith<T>(type: T.Type)
       
       func removeAllChildCoordinators()
}

extension Coordinator {
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

}
