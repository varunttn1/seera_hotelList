//
//  UIImageExtensions.swift
//  HotelListing
//
//  Created by Varun Kumar on 1/7/21.
//

import UIKit

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
