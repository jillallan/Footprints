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
    
    var locationManager: MockLocationManager!
    var randomLocation: CLLocation!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationManager = MockLocationManager(
            allowsBackgroundLocationUpdates: true,
            showsBackgroundLocationIndicator: true,
            authorizationStatus: CLAuthorizationStatus.authorizedAlways
        )
        
        let randomCoordinate = CLLocationCoordinate2D.random()
        randomLocation = CLLocation(
            latitude: randomCoordinate.latitude,
            longitude: randomCoordinate.longitude
        )
        
        cancellables = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor 
    func test_LocationHandler_() throws {
        
        let requestLocationExpectation = expectation(description: "request Location")
        locationManager.handleRequestLocation = {
            requestLocationExpectation.fulfill()
            return self.randomLocation
        }
        
        let container = MockDataContainer(inMemory: true)
        let handler = LocationHandler(context: container.container.mainContext, locationManager: locationManager)
        
        let completionExpectation = expectation(description: "completion")
        
        handler.getCurrentLocation { location in
            XCTAssertEqual(location, self.randomLocation)
            completionExpectation.fulfill()
        }
        
        wait(for: [requestLocationExpectation, completionExpectation], timeout: 1)
    }
    
    @MainActor
    func test_LocationHandler_Async() async throws {
        
        let requestLocationExpectation = expectation(description: "request Location")
        locationManager.handleRequestLocation = {
            requestLocationExpectation.fulfill()
            return self.randomLocation
        }
        
        let container = MockDataContainer(inMemory: true)
        let handler = LocationHandler(context: container.container.mainContext, locationManager: locationManager)
        
        let location = try await handler.getCurrentLocation()
        await fulfillment(of: [requestLocationExpectation])
        
        XCTAssertEqual(location, self.randomLocation)
        
    }

    @MainActor
    func test_LocationHandler_combine() throws {
        
        let requestLocationExpectation = expectation(description: "request Location")
        locationManager.handleRequestLocation = {
            requestLocationExpectation.fulfill()
            return self.randomLocation
        }
        
        let container = MockDataContainer(inMemory: true)
        let handler = LocationHandler(context: container.container.mainContext, locationManager: locationManager)
        
        var locations = [CLLocation]()
        var error: Error?
        
        handler.getCurrentLocation()
        
        
        handler
            .locationPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                requestLocationExpectation.fulfill()
            }, receiveValue: { value in
                 locations = value
            })
            .store(in: &cancellables)
        
        wait(for: [requestLocationExpectation], timeout: 1)
        
        XCTAssertNil(error)
        XCTAssertEqual(locations.first, randomLocation)

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
