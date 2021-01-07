//
//  Environment.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

enum Environment {
    case stage
    case uat
    case prod
    
    var urlProtocol: String {
        switch self {
        case .stage, .uat, .prod:
            return "https"
        }
    }
    // https://sgerges.s3-eu-west-1.amazonaws.com/iostesttaskhotels.json
    var appDomain: String {
        switch self {
        case .stage:
            return "sgerges.s3-eu-west-1.amazonaws.com"

//            return "95d17a40-bf07-4b30-bd8b-b7744b00fbdb.mock.pstmn.io"
        case .uat:
            return "uat"
        case .prod:
            return "prod"
        }
    }

    var router: String {
        switch self {
        case .stage, .uat, .prod:
            return ""
        }
    }
    
    var baseUrl: String {
        return urlProtocol+"://"+appDomain+"/"+router
    }
}
