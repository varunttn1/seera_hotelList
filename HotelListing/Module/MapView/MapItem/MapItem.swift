//
//  MapItem.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

import MapKit

final class MapItem: NSObject, MKAnnotation {
    enum ItemType: UInt32 {
        case green = 0
        case orange = 1
        
        var image: UIImage {
            switch self {
            case .green:
                return #imageLiteral(resourceName: "box")
            case .orange:
                return #imageLiteral(resourceName: "box")
            }
        }
    }
    
    let coordinate: CLLocationCoordinate2D
    let itemType: ItemType
    var image: UIImage { return itemType.image }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.itemType = ItemType(rawValue: arc4random_uniform(2)) ?? .green
    }
}
