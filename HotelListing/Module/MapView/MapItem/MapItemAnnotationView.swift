//
//  MapItemAnnotationView.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

import MapKit

final class MapItemAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            guard let mapItem = annotation as? MapItem else { return }
            clusteringIdentifier = "MapItem"
            image = mapItem.image
        }
    }
}
