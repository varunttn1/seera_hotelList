//
//  RouteDefinition.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

typealias Parameters = [String : Any]
typealias HTTPHeaders = [String : String]

protocol RouteDefinition: RequestDefinition {
    var httpMethod: HTTPMethod {get}
    var baseUrl: String {get}
    var path: String {get}
    var headers: HTTPHeaders? {get}
    var parameters: Parameters? {get}
    var paramEncoder: ParamEncodable { get }
}
