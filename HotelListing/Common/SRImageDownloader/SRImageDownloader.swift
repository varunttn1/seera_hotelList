//
//  SRImageDownloader.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation
import UIKit

final class SRImageDownloader{
    
    static let shared = SRImageDownloader()
    
    private let cache = SRImageCache()

    func downloadImage(from url: URL, completion: @escaping ((UIImage?, Error?)->())) {
         
        if let image = cache[url] {
            completion(image, nil)
            return
        }
        
//        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.cache[url] = image
                completion(image, nil)
            }else {
                completion(nil, nil)

            }
        }.resume()
    }
}
