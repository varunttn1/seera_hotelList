//
//  HotelDataSource.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//


import Foundation

typealias HotelAPICompletionHandler = (Result<[Hotel], Error>) -> Void

protocol HotelFetchable {
    func fetchHotels(completion: @escaping HotelAPICompletionHandler)
    var allHotels: [Hotel] {get}
}

class HotelDataSource: HotelFetchable {
    var allHotels: [Hotel]{
        fetchedHotels
    }
    
    private (set) var apiService: HotelAPIService
    private var fetchedHotels: [Hotel] = []
    
    init(apiService: HotelAPIService) {
        self.apiService = apiService
    }
    
    // MARK: - Fetch Hotels
    /// This method call the api service to fetch hotels from server, on the successful api call provide the HotelItemViewModel which contains all the hotel further it mapped it to appropriate model to which use to show data on cell.
    /// - Parameter completion: HotelCompletionHandler, This will contain result success with array of HotelItemViewModel and in case of failed it provide error
    func fetchHotels(completion: @escaping HotelAPICompletionHandler) {
        self.apiService.fetchHotel(params: [:]) {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let hotels):
                    self.fetchedHotels = hotels
                    completion(.success(self.fetchedHotels))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
}
