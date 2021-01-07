//
//  UIGraphicsImageRenderer.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation
import UIKit
import MapKit

extension UIGraphicsImageRenderer {
    static func image(for annotations: [MKAnnotation], in rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        let totalCount = annotations.count
        let orangeCount = annotations.orangeCount
        
        let countText = "\(totalCount)"
        
        return renderer.image { _ in
            UIColor.red.setFill()
            UIBezierPath(ovalIn: rect).fill()
            
            UIColor.red.setFill()
            let piePath = UIBezierPath()
            piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
                           startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(orangeCount)) / CGFloat(totalCount),
                           clockwise: true)
            piePath.addLine(to: CGPoint(x: 20, y: 20))
            piePath.close()
            piePath.fill()
            
            UIColor.white.setFill()
            UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
            
            countText.drawForCluster(in: rect)
        }
    }
}

extension Sequence where Element == MKAnnotation {
    var orangeCount: Int {
        return self
            .compactMap { $0 as? MapItem }
            .filter { $0.itemType == .orange }
            .count
    }
}
