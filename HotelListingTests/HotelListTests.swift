//
//  HotelListTests.swift
//  HotelListingTests
//
//  Created by Varun Kumar on 07/01/21.
//

import XCTest
@testable import HotelListing


class HotelListTests: XCTestCase {
    
    var sut: HotelAPIService!
    var sut1: NetworkExecutor<HotelRouter>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = HotelAPIService()
        sut1 = NetworkExecutor<HotelRouter>()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        sut1 = nil
        
    }

   
    
    func testNetworkRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let resultExpectation = expectation(description: "Result should not be nil")
        
        sut1.excuteRequest(HotelRouter.fetchHotels([:])) { (data, response, error) in
            XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200)
            resultExpectation.fulfill()
        }
        
        wait(for: [resultExpectation], timeout: 30)
    }

    func testServiceResponse() {
        let resultExpectation = expectation(description: "Result should not be nil")
        
        sut.fetchHotel(params: [:]) { (result) in
            switch result {
            case .success(let model):
                XCTAssertNotNil(model)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            resultExpectation.fulfill()
        }
        
        wait(for: [resultExpectation], timeout: 30)
    }
}
