//
//  BaseNavigationController.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
    }
}

