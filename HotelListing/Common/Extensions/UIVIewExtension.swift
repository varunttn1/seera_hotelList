//
//  UIVIewExtension.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation
import UIKit

extension UIView {
    func setCardView(){
        backgroundColor = .white
        layer.cornerRadius = 3.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.8
    
    }
}
