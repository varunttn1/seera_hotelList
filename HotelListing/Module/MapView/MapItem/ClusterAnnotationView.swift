//
//  ClusterAnnotationView.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

import UIKit
import MapKit

final class ClusterAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let cluster = annotation as? MKClusterAnnotation else { return }
            displayPriority = .defaultHigh
            
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
        }
    }
}
