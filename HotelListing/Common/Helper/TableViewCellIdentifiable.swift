//
//  TableViewCellIdentifiable.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation
import UIKit

protocol ReuseIdentifiable {
    static var resuseIdentifier: String { get }
}

extension ReuseIdentifiable where Self: UITableViewCell {
   
    static var resuseIdentifier: String {
        return String(describing: self)
    }
}
