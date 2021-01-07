//
//  AppError.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

enum AppError: Error {
    
    enum RequestError: Error {
        case invalidURL(message: String)
    }
    
    enum APIError: Error {
        case noInternet(message: String)
    }
}
