//
//  ServiceRequestExecutable.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

typealias ServiceRequestDataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

protocol ServiceRequestExecutable: class {
    associatedtype ServiceRequest: RouteDefinition
    
    func excuteRequest(_ service: ServiceRequest, completion: @escaping ServiceRequestDataTaskCompletion)
    func cancel()
}
