//
//  ArrayExtension.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

/// Return true if a Array contains at least one element.
public extension Array {
   var isNotEmpty: Bool { return !isEmpty }
}



extension Array where Element == HotelItemViewModel {
   
    func sortByDistance() -> [HotelItemViewModel] {
         self.sorted {$0.distance < $1.distance}
    }
    
    func sortByPrice() -> [HotelItemViewModel] {
        self.filter {$0.price != nil}.sorted {$0.price! < $1.price!}
    }
    
    func  sortByStarRating() -> [HotelItemViewModel] {
        self.filter {$0.starRating != nil}.sorted {$0.starRating! < $1.starRating!}
    }
    
    func  sortByPriority() -> [HotelItemViewModel] {
        self.sorted {$0.priority < $1.priority}
    }
    
}
