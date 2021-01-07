//
//  APIResponse.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

enum APIResult<String>{
    case success
    case failure(String)
}

enum APIResponse:String, Error {
    case success
    case authenticationError = "Authentication required."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case nilResponse = "Url response nil."
}

protocol ResponseRepresentable {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> APIResult<Error>
}

extension ResponseRepresentable {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> APIResult<Error>{
        switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(APIResponse.authenticationError)
            case 501...599: return .failure(APIResponse.badRequest)
            case 600: return .failure(APIResponse.outdated)
            default: return .failure(APIResponse.failed)
        }
    }
}
