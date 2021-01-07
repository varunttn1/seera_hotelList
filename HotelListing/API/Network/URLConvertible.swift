//
//  URLConvertible.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self)
            else { throw AppError.RequestError.invalidURL(message: "Invalid URL string") }
        return url
    }
    
}
