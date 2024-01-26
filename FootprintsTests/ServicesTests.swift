//
//  ServicesTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 06/01/2024.
//

import MapKit
import XCTest
@testable import Footprints

final class ServicesTests: XCTestCase {
    var locationName = ""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMapSearchService_returnsResultsForLocation() throws {
        let mapSearchService = MapSearchService()
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        let expectation = expectation(description: "Map Search")
        
        Task {
            await mapSearchService.search(for: "Coffee", in: region)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        print(mapSearchService.searchResults)
        
        XCTAssertGreaterThan(mapSearchService.searchResults.count, 0)

    }
    
//    actor LocationNameActor {
//        var locationName = ""
//        
//        func setLocationName(name: String) {
//            locationName = name
//        }
//    }
    
    func testLocationServiceFetchesPlacemarkForLocation() throws {
        let locationService = LocationService()
        let step = Step(timestamp: Date.now, latitude: 51.50867140101967, longitude: -0.07598862930584746)
        let expectation = expectation(description: "Geocode Location")

        
        Task {
            let result = await locationService.fetchPlacemark(for: step)
            switch result {
            case .success(let cLPlacemark):
                locationName = cLPlacemark.name ?? "No name"
                expectation.fulfill()
            case .failure(let error):
                return
            }
        }
        
        waitForExpectations(timeout: 3)
        print(locationName)
        XCTAssertEqual(locationName, "Tower of London")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
