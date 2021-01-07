//
//  BaseViewController.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import UIKit

class BaseViewController: UIViewController, ViewControllerFromStoryboard {
    static var storyboardName: String = "Main"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
}
