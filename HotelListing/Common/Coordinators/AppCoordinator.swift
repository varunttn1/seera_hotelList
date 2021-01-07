//
//  AppCoordinator.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import UIKit

class AppCoordinator: BaseCoordinator {
        
    var window: UIWindow!
    
    required init(window: UIWindow) {
        super.init()
        self.window = window
    }
    
    override func start() {
        navigateToContainer()
    }
    
    override func finish() {
        
    }
 
}


extension AppCoordinator {
    
    func navigateToContainer() {
        let coordinator = ContainerCoordinator()
        self.start(coordinator)
        window.rootViewController = coordinator.navigationController
        self.window.makeKeyAndVisible()
    }
}
