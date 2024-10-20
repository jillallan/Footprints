//
//  TestLocationService.swift
//  FootprintsTests
//
//  Created by Jill Allan on 06/10/2024.
//

import RealModule
import Testing
import CoreLocation
@testable import Footprints

struct TestLocationService {

    @Test func testFetchPlacemark_returnsAPlacemark() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let locationService = LocationService()
        
        let location = CLLocation(latitude: 51.370791, longitude: -2.546549)
        let placemark = try await locationService.fetchPlacemark(for: location)
        #expect(placemark?.name == "138 High Street")

    }
    
    @Test func testFetchLocation_returnsALocation() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let locationService = LocationService()
        
        let address = "138 High Street, Pensford, BS39 4BH"
        
        let expectedLocation = CLLocation(latitude: 51.370791, longitude: -2.546549)
        let location = try await locationService.fetchLocation(for: address)
        
        let fetchedLocation = try #require(location)
        #expect(fetchedLocation.coordinate.latitude.isApproximatelyEqual(to: expectedLocation.coordinate.latitude))

    }
    
    @Test func testFetchPlacemarkForAddress_returnsAPlacemark() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let locationService = LocationService()
        
        let address = "138 High Street, Pensford, BS39 4BH"
        
        let expectedLocation = CLLocation(latitude: 51.370791, longitude: -2.546549)
        let placemark = try await locationService.fetchPlacemark(for: address)
        
        let fetchedLocation = try #require(placemark?.location)
        #expect(fetchedLocation.coordinate.latitude.isApproximatelyEqual(to: expectedLocation.coordinate.latitude))

    }
}
