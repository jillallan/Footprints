//
//  TripTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/10/2023.
//

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

}
