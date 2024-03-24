//
//  LocationHandlerTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 11/03/2024.
//

import Combine
import CoreLocation
import XCTest
@testable import Footprints

final class LocationHandlerTests: XCTestCase {
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func test_locationHandler_currentLocation_returnsALocation() async throws {
        // if
        var locationManager = MockLocationManager(
            allowsBackgroundLocationUpdates: true,
            showsBackgroundLocationIndicator: true,
            authorizationStatus: CLAuthorizationStatus.authorizedAlways
        )
        
        let randomCoordinate = CLLocationCoordinate2D.random()
        let randomLocation = CLLocation(
            latitude: randomCoordinate.latitude,
            longitude: randomCoordinate.longitude
        )
        
        locationManager.handleRequestLocationCompletion = { randomLocation }

        let container = MockDataContainer(inMemory: true)
        let locationHandler = LocationHandler(context: container.container.mainContext, locationManager: locationManager)

        // when
        let location = try await locationHandler.currentLocation()

        // then
        XCTAssertEqual(location, randomLocation)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
