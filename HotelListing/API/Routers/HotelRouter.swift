//
//  HotelRouter.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

enum HotelRouter {
    case fetchHotels(_ param: Parameters?)
}

extension HotelRouter: RouteDefinition {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchHotels:
            return .GET
        }
    }
        
    var baseUrl: String {
        switch self {
        case .fetchHotels:
            return kAppBaseUrl
        }
    }
    
    var path: String {
        switch self {
        case .fetchHotels:
            return kHotelListing
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchHotels(let param):
            return param
        }
    }
    
    var paramEncoder: ParamEncodable {
        switch self {
        case .fetchHotels:
            return URLEncode()
        }
    }
    
    var urlRequest: URLRequest {
        var url = try? baseUrl.asURL()
        url?.appendPathComponent(path)
        
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.httpMethod = httpMethod.methodName
        request.allHTTPHeaderFields = headers
        do {
            try paramEncoder.encode(parameters, with: &request)
        } catch {
            debugPrint(error)
        }
        return request
    }
}
