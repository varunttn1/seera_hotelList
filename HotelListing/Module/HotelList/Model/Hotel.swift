//
//  Hotel.swift
//  HotelListing
//
//  Created by Varun Kumar on 1/5/21.
//

import Foundation

// MARK: - Hotel
struct Hotel: Codable {
    var atgHotelID: Int
    var price :Int?
    var hotelChainID: Int?
    var propertyTypeID: Int
    var name: DistanceDetails?
    var starRating: Int?
    var thumbnailURL: String?
    var area: Area?
    var rank: Int?
    var longitude, latitude, distance, distanceInMeters: Double
    var address: DistanceDetails?
    var distanceScore, priorityScore: Double?
    var similarityScore: Int?
    var facilityIDS: [Int]?
    var review: Review?
    var topPicks: TopPicks?

    enum CodingKeys: String, CodingKey {
        case atgHotelID = "atgHotelId"
        case price
        case hotelChainID = "hotelChainId"
        case propertyTypeID = "propertyTypeId"
        case name, starRating
        case thumbnailURL = "thumbnailUrl"
        case area, rank, longitude, latitude, distance, distanceInMeters, address, distanceScore, priorityScore, similarityScore
        case facilityIDS = "facilityIds"
        case review, topPicks
    }
}

// MARK: - DistanceDetails
struct DistanceDetails: Codable {
    var en: String?
    var ar: String?
}

// MARK: - Review
struct Review: Codable {
    var hotelID, count: Int
    var name: String?
    var sourcesCount: Double?
    var score: Double?
    var scoreDescription: DistanceDetails?
    var scoreColor: ScoreColor?

    enum CodingKeys: String, CodingKey {
        case hotelID = "hotelId"
        case count, name, sourcesCount, score, scoreDescription, scoreColor
    }
}

enum ScoreColor: String, Codable {
    case a1Cc4F = "#A1CC4F"
    case f5A623 = "#F5A623"
    case f77D12 = "#F77D12"
    case the129911 = "#129911"
    case the71Bc4C = "#71BC4C"
}

// MARK: - TopPicks
struct TopPicks: Codable {
    var hotelID: Int
    var distance: DistanceDetails?
    var subcategories: DistanceDetails?
    var topPicksDescription: DistanceDetails?
    var categories: Categories?

    enum CodingKeys: String, CodingKey {
        case hotelID = "hotelId"
        case distance, subcategories
        case topPicksDescription = "description"
        case categories
    }
}

// MARK: - Categories
struct Categories: Codable {
    var en: String?
    var ar: String?
    var iconLink: String?
}


struct Name: Codable {
    let en: String?
    let ar: String?
    enum CodingKeys: String, CodingKey {
        case en, ar
    }
}

struct Area: Codable {
    let id: Int?
    let nameAr: String?
    let nameEn: String?
    enum CodingKeys: String, CodingKey {
        case id, nameAr, nameEn
    }
}

struct Address: Codable {
    let en: String?
    let ar: String?
    enum CodingKeys: String, CodingKey {
        case en, ar
    }
}

