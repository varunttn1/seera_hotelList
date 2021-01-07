//
//  HotelAPIService.swift
//  HotelListing
//
//  Created by Varun Kumar on 04/01/21.
//

import Foundation

typealias HotelCompletionBlock = (Result<[Hotel], Error>)  -> Void

class HotelAPIService: NetworkExecutor<HotelRouter>, ResponseRepresentable {

    func fetchHotel(params: Parameters, completion: @escaping HotelCompletionBlock) {
        excuteRequest(HotelRouter.fetchHotels(params)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let response = response as? HTTPURLResponse {
                let apiResult = self.handleNetworkResponse(response)
                switch apiResult {
                case .success:
                    if let data = data {
                        do {
                            let hotelAPIResponse = try JSONDecoder().decode(HotelAPIResponse.self, from: data)
                            completion(.success(hotelAPIResponse.hotels!))
                            return
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(APIResponse.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIResponse.nilResponse))
            }
        }
    }
}
