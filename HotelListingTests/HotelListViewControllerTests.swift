//
//  HotelListViewControllerTests.swift
//  HotelListingTests
//
//  Created by Varun Kumar on 07/01/21.
//

import XCTest
@testable import HotelListing

class HotelListViewControllerTests: XCTestCase {

    var viewControllerUnderTest: HotelListViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "HotelListViewController") as? HotelListViewController
        
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.viewDidLoad()
        
        // data source

        let hotel1 = Hotel(atgHotelID: 1538068, price: 259, hotelChainID: 188, propertyTypeID: 17, name: DistanceDetails(en: "TRYP by Wyndham Dubai", ar: "تريب باي ويندام دبي"), starRating: 4, thumbnailURL: "http://hotelcms-contents-live.tajawal.com/97fa97b8-a475-46a2-9b1d-a2995b55ce0f.jpg", area: Area(id: 63, nameAr: "برشا هايتس", nameEn: "Barsha Heights"), rank: 1965, longitude: 55.17477966749379, latitude: 25.097271599664083, distance: 15.0, distanceInMeters: 15381.7, address: DistanceDetails(en: "Al Seef Street 1 Barsha Heights, Tecom, Dubai, United Arab Emirates", ar: "شارع السيف 1 برشا هايتس, تيكوم, دبي, الإمارات العربية المتحدة"), distanceScore: 0.658184, priorityScore: 0.9825, similarityScore: 0, facilityIDS: [23, 38], review: nil, topPicks: nil)
        
        let hotel2 = Hotel(atgHotelID: 1538068, price: 259, hotelChainID: 188, propertyTypeID: 17, name: DistanceDetails(en: "TRYP by Wyndham Dubai", ar: "تريب باي ويندام دبي"), starRating: 4, thumbnailURL: "http://hotelcms-contents-live.tajawal.com/97fa97b8-a475-46a2-9b1d-a2995b55ce0f.jpg", area: Area(id: 63, nameAr: "برشا هايتس", nameEn: "Barsha Heights"), rank: 1965, longitude: 55.17477966749379, latitude: 25.097271599664083, distance: 15.0, distanceInMeters: 15381.7, address: DistanceDetails(en: "Al Seef Street 1 Barsha Heights, Tecom, Dubai, United Arab Emirates", ar: "شارع السيف 1 برشا هايتس, تيكوم, دبي, الإمارات العربية المتحدة"), distanceScore: 0.658184, priorityScore: 0.9825, similarityScore: 0, facilityIDS: [23, 38], review: nil, topPicks: nil)
        
        let hotel3 = Hotel(atgHotelID: 1538068, price: 259, hotelChainID: 188, propertyTypeID: 17, name: DistanceDetails(en: "TRYP by Wyndham Dubai", ar: "تريب باي ويندام دبي"), starRating: 4, thumbnailURL: "http://hotelcms-contents-live.tajawal.com/97fa97b8-a475-46a2-9b1d-a2995b55ce0f.jpg", area: Area(id: 63, nameAr: "برشا هايتس", nameEn: "Barsha Heights"), rank: 1965, longitude: 55.17477966749379, latitude: 25.097271599664083, distance: 15.0, distanceInMeters: 15381.7, address: DistanceDetails(en: "Al Seef Street 1 Barsha Heights, Tecom, Dubai, United Arab Emirates", ar: "شارع السيف 1 برشا هايتس, تيكوم, دبي, الإمارات العربية المتحدة"), distanceScore: 0.658184, priorityScore: 0.9825, similarityScore: 0, facilityIDS: [23, 38], review: nil, topPicks: nil)
    
        let hotels = [HotelItemViewModel(hotel1),  HotelItemViewModel(hotel2), HotelItemViewModel(hotel3)]
        viewControllerUnderTest.viewModel.allHotels = hotels

       // viewControllerUnderTest.viewModel.venues = venues
        viewControllerUnderTest.hotelTableView.reloadData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewControllerUnderTest = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testHasTableView() {
        XCTAssertNotNil(viewControllerUnderTest.hotelTableView, "view controller has table view")
    }
    
    func testHasTableViewDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.hotelTableView.dataSource)
    }

    func testHasTableViewDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.hotelTableView.delegate)
    }
    
    func testHasTableViewConfromsUITableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    
    func testHasTableViewConfromsUITableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
   
    
}
