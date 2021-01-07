//
//  HotelContainerCoordinator.swift
//  HotelListing
//
//  Created by Varun Kumar on 1/7/21.
//

import Foundation

class ContainerCoordinator: BaseCoordinator {
    
    override func start() {
        let containerViewController: ContainerViewController = ContainerViewController.viewController()
        navigationController.viewControllers = [containerViewController]
    }
    
    override func finish() {
            
    }
}
