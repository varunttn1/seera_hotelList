//
//  NetworkExecutor.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

class NetworkExecutor<ServiceRequest: RouteDefinition>: ServiceRequestExecutable {
    
    private var task: URLSessionDataTask?
    
    func excuteRequest(_ service: ServiceRequest, completion: @escaping ServiceRequestDataTaskCompletion) {
        let urlSession = URLSession.shared
        self.task = urlSession.dataTask(with: service.urlRequest, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    
}
