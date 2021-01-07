//
//  ParamEncodable.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

protocol ParamEncodable {
    func encode(_ params: Parameters?, with request: inout URLRequest) throws
}

struct URLEncode: ParamEncodable {
    func encode(_ params: Parameters?, with request: inout URLRequest) throws {
        guard let parameters = params else { return }
        guard let url = request.url else { throw AppError.RequestError.invalidURL(message: "No URL found") }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            })
            request.url = urlComponents.url
        }
    }
        
    
}
