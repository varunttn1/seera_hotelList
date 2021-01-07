//
//  HTTPMethod.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    var methodName: String { return rawValue.uppercased() }
}
