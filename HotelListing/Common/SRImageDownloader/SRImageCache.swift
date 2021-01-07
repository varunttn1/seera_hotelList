//
//  SRImageCache.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

import UIKit

final class SRImageCache {
    
    // 1st level cache, that contains encoded images
       private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
           let cache = NSCache<AnyObject, AnyObject>()
            cache.totalCostLimit = 1024 * 1024 * 50
           return cache
       }()
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()

        imageCache.setObject(decodedImage, forKey: url as AnyObject)
    }

    func removeImage(for url: URL) {
        imageCache.removeObject(forKey: url as AnyObject)
    }

}

extension SRImageCache {
    
    func image(for url: URL) -> UIImage? {

        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            return decodedImage
        }
        return nil
    }
}

extension SRImageCache {
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
    
}
