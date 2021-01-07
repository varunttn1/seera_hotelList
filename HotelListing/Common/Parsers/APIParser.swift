//
//  HotelAPIParser.swift
//  HotelListing
//
//  Created by Varun Kumar on 1/6/21.
//

import Foundation

protocol APIParser {
    func parse<T: Codable>(data: Data, completionHandler: ((T?, HotelAPIError?)->())?)
}
