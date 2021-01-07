//
//  HotelViewModel.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import Foundation

typealias HotelCompletionHandler = (Result<[HotelItemViewModel], Error>) -> Void

protocol HotelViewModelType: AnyObject {
    func updateDataSource(sortedBy: SortBy)
    func resetDataSource()
    func loadMoreData() -> (startIndex: Int, endIndex: Int)
    func filterHotels(_ hotel: String)
    func clearFilter()
    func fetchHotelItems(completion: @escaping HotelCompletionHandler)
    func numberOfRows() -> Int
    func itemViewModel(at indexPath: IndexPath) -> HotelItemViewModel
    var reachedEndOfItems: Bool{ get }
}


class HotelViewModel: HotelViewModelType {
    
    var hotelDataSource: HotelFetchable
    
    var filteredHotels: [HotelItemViewModel]?
    var dataSourceArray = [HotelItemViewModel]()
    var allHotels = [HotelItemViewModel]()
    
    let itemsPerBatch = 10
    private (set) lazy var reachedEndOfItems: Bool =  false
    // MARK: - Initialisation
    
    init(hotelDataSource: HotelFetchable) {
        self.hotelDataSource = hotelDataSource
    }
    
    func fetchHotelItems(completion: @escaping HotelCompletionHandler) {
        hotelDataSource.fetchHotels {[weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let hotels):
                    self.allHotels = self.mapViewModel(hotels: hotels)
                    completion(.success(self.allHotels))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// This method mapped the Hotel model to HotelItemViewModel which use further to display data on cell
    /// - Parameter hotels: Hotel
    private func mapViewModel(hotels: [Hotel]) -> [HotelItemViewModel] {
        var hotelArray = [HotelItemViewModel]()
        hotelArray = hotels.map{
            return HotelItemViewModel($0)
        }
        return hotelArray
    }
    
    ///  inserting the items 10 by 10 in  data source array for lazy loading and returns the startIndex and endIndex.
    func loadMoreData() -> (startIndex: Int, endIndex: Int) {
        let requiredHotels = filteredHotels ?? allHotels
        let startIndex = dataSourceArray.count
        let endIndex = dataSourceArray.count + itemsPerBatch
        
        if endIndex >= requiredHotels.count {
            dataSourceArray += requiredHotels[startIndex..<requiredHotels.count]
            reachedEndOfItems = true
            return (startIndex, requiredHotels.count )
        }else {
            dataSourceArray += requiredHotels[startIndex..<endIndex]
            return (startIndex, endIndex )
        }
        
    }
    
    ///
    func updateDataSource(sortedBy: SortBy) {
        allHotels =  sortBy(sortedBy)
    }
    
    /// This method sort hotels list depend on the distance, starRating, LowestPrice
    /// - Parameter SortBy Enum :
    private func sortBy(_ type: SortBy) -> [HotelItemViewModel] {
        switch type {
        case .distance:
            return allHotels.sortByDistance()
        case .starRating:
            return allHotels.sortByStarRating()
        case .lowestPrice:
            return allHotels.sortByPrice()
        default:
            return allHotels.sortByPriority()
        }
    }
    
    /// filter the hotels by passing the enter string in search box.
    func filterHotels(_ hotel: String) {
        filteredHotels = allHotels.filter{ $0.title?.contains(hotel) == true}
    }
    
    /// when user clear all the typed string in search box.
    func clearFilter() {
        filteredHotels = nil
    }
    
    /// reset the rows array once user select any sorting, start to serach any hotel in search box, clear the text in search box.
    func resetDataSource() {
        dataSourceArray.removeAll()
        reachedEndOfItems = false
    }
}

extension HotelViewModel {
    
    /// number of section in hotel tableview
    func numberOfSections() -> Int {
        return 1
    }
    /// number of rows in hotel tableview
    func numberOfRows() -> Int{
        return dataSourceArray.count
    }
    
    /// hotel items in tableview cell
    func itemViewModel(at indexPath: IndexPath) -> HotelItemViewModel{
        return dataSourceArray[indexPath.row]
    }
}

