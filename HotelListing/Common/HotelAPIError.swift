//
//  CRError.swift
//  HotelListing
//
//  Created by Varun Kumar on 1/6/21.
//

import Foundation

public enum HotelAPIError: Error {
    case error(Error)
    case description(String)
    case noInternet
    case noData
    case notAbleToParseData
    
    var description: String {
        
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .description(let description):
            return description
        case .noInternet:
            return "Please check your internet connection, restart App and try again."
        case .noData:
            return "No Data Found"
        case .notAbleToParseData:
            return "Not able to parse data"
        }
        
    }
}
