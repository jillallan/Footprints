//
//  TripTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/10/2023.

import CoreLocation
import SwiftData
import XCTest
@testable import Footprints

final class TripTests: BaseTestCase {

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testTrip_AddTrip_AddsTrip() throws {
        let descriptor = FetchDescriptor<Trip>()
        let trips = try modelContext.fetchCount(descriptor)
        
        XCTAssertEqual(trips, 0)
        
        modelContext.insert(Trip.bedminsterToBeijing)
        let tripsCount = try modelContext.fetchCount(descriptor)
        
        XCTAssertEqual(tripsCount, 1)
    }

    func testTrip_ChangeTitle_ChangesDebugDescription() {
        // if
        let trip = Trip.bedminsterToBeijing
        modelContext.insert(trip)
        
        let randomWord = String.randomWord()
        
        // when
        trip.title = randomWord
        let newDebugDescription = trip.debugDescription
        
        // then
        XCTAssertNotEqual(newDebugDescription, randomWord)
    }
    
    func test_TripDates_WhenStartAndEndInSameMonth_ReturnsShortenedDates() {
        // if
        let trip = Trip.mountains
        modelContext.insert(trip)
        
        XCTAssertEqual(trip.tripDates, "3 - 30 Sep 2019")
    }
    
    func test_TripDetailView_getLocationCoordinates_whenNoLocationsServices_returnsLocaleLocation() {
        modelContext.insert(Trip.bedminsterToBeijing)
        let tripDetailView = TripDetailView2(trip: Trip.bedminsterToBeijing)
        
        let coordinate = tripDetailView.getLocation()
        print(coordinate)
        
        XCTAssertEqual(coordinate, CLLocation(latitude: 55.378051, longitude: -3.435973))
    }
    
    func test_TripDetailView_getLocationCoordinates_returnsLocation() {

    }

}
