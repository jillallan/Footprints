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
    var location = CLLocation(latitude: 51.5, longitude: 0.0)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
 

//    func testMapSearchService_returnsResultsForLocation() throws {
//        let mapSearchService2 = MapSearchService()
//        let region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0),
//            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        )
//        let expectation = expectation(description: "Map Search")
//        
//        Task {
//            await mapSearchService2.search(for: "Coffee", in: region)
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 3)
//        print(mapSearchService2.searchResults)
//        
//        XCTAssertGreaterThan(mapSearchService2.searchResults.count, 0)
//
//    }
    
    
    
//    @MainActor func testStartLocationUpdates_shouldUpdateLastLocation() throws {
//        let locationHandler = LocationHandler()
////        locationHandler.startLocationUpdates()
//        
//        let expectation = expectation(description: "Start location updates")
//        locationHandler.startLocationUpdates()
//        
//        locationHandler.getLastLocation = { loc in
//            XCTAssertEqual(loc, CLLocation(latitude: 51.5, longitude: 0.0))
//            expectation.fulfill()
//        }
//        
//        locationHandler.startLocationUpdates()
//        
//        waitForExpectations(timeout: 3)
// 
//    }
    
//    actor LocationNameActor {
//        var locationName = ""
//        
//        func setLocationName(name: String) {
//            locationName = name
//        }
//    }
    
    func testLocationServiceFetchesPlacemarkForLocation() throws {
        let locationService = MapService()
        let step = Step(timestamp: Date.now, latitude: 51.50867140101967, longitude: -0.07598862930584746)
        let expectation = expectation(description: "Geocode Location")

        
        Task {
            let result = await locationService.fetchPlacemark(for: step)
            switch result {
            case .success(let cLPlacemark):
                locationName = cLPlacemark.name ?? "No name"
                expectation.fulfill()
            case .failure(let error):
                print(error)
                return
            }
        }
        
        waitForExpectations(timeout: 3)
        print(locationName)
        XCTAssertEqual(locationName, "Tower of London")
    }
    
    func testLocationServiceFetchesLocationForAddress() throws {
        let locationService = MapService()
//        let step = Step(timestamp: Date.now, latitude: 51.50867140101967, longitude: -0.07598862930584746)
        guard let region = Locale.current.region?.debugDescription else { return }

        
        print("region is: \(String(describing: region))")
        let expectation = expectation(description: "Geocode Location")
        
        
        
        Task {
            let result = await locationService.fetchLocation(for: region)
            switch result {
            case .success(let cLLocation):
                location = cLLocation
                expectation.fulfill()
            case .failure(let error):
                print(error)
                return
            }
        }
        
        waitForExpectations(timeout: 3)
        print(location)
        XCTAssertEqual(location.coordinate.latitude, 54.26, accuracy: 2) //54.26

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
