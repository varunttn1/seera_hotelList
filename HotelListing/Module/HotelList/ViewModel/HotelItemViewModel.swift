//
//  HotelItemViewModel.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

protocol HotelItemRepresentable {
    var imageURL: URL? { get }
    var title: String? { get }
    var starRatingString: String? { get }
    var priceString: String? { get }
    var address: String? { get }
}

class HotelItemViewModel: HotelItemRepresentable {
    
    private let hotel: Hotel

    // MARK: - Initialisation
    init(_ hotel: Hotel) {
        self.hotel = hotel
    }
    
    /// This property wiil return image URL
    var imageURL: URL? {
        return URL(string: hotel.thumbnailURL ?? "")
    }
    
    /// This will return the name of the hotel
    var title: String? {
        if getAppLanguage() == languageAr {
            return hotel.name?.ar
        }
        return hotel.name?.en
    }
    
    var priority: Int {
        return hotel.atgHotelID
    }
    
    var price: Int? {
        return hotel.price
    }
    
    var distance: Double {
        return hotel.distance
    }
    
    var starRating: Int? {
        return hotel.starRating
    }
    
    /// This will return the starRating of the hotel
    var starRatingString: String? {
        if let starRating = starRating {
            return "\(starRating)"
        }
        return ""
    }
    
    /// This will return the address of the hotel
    var address: String? {
        if getAppLanguage() == languageAr {
            return hotel.address?.ar
        }
        return hotel.address?.en
    }
    
    /// This will return the price of the hotel
    var priceString: String? {
        if let price = price {
        return "\(price)"
        }
        return ""
    }
   
}
