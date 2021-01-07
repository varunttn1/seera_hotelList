//
//  HotelAPIResponse.swift
//  HotelListing
//
//  Created by Varun Kumar on 1/6/21.
//

import Foundation

struct HotelAPIResponse: Codable {
    
    var sortBy: String?
    var hotels: [Hotel]?
    
    private enum CodingKeys: String, CodingKey {
        case sortBy
        case hotels
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            sortBy = try values.decode(String.self, forKey: .sortBy)
        }catch {
            print("sortBy error \(error.localizedDescription)")
        }
        
        var hotelDictionaries = [String: Hotel]()
        
        do{
            hotelDictionaries = try values.decode([String:Hotel].self, forKey: .hotels)
        }catch {
            print("hotels error \(error.localizedDescription)")
        }
        
        hotels = hotelDictionaries.map({ (key: String, value: Hotel) -> Hotel in
            return value
        })

    }
    
    func encode(to encoder: Encoder) throws {
    }
}
