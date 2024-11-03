//
//  TestLocationService.swift
//  FootprintsTests
//
//  Created by Jill Allan on 06/10/2024.
//

import RealModule
import Testing
import CoreLocation
import MapKit
@testable import Footprints

struct TestLocationService {

    @Test func testFetchPlacemark_returnsAPlacemark() async throws {
        
    }
    
    @Test func testFetchLocation_returnsALocation() async throws {

    }
    
    @Test func testFetchPlacemarkForAddress_returnsAPlacemark() async throws {
        
    }
    
    @Test func testSearch_returns() async throws {

    }
    
    @Test func testSearchForPointOfInterest_returns() async throws {

    }
    
    @Test func testSearchForPhysicalFeature_returns() async throws {

    }
    
    @Test func testSearchForAddress_returns() async throws {

    }
    
    @Test func example4() async throws {
        let locationService = LocationService()
//        let atomium = CLLocationCoordinate2D(latitude: 50.89504108327435,
//                                             longitude: 4.34157615494866)
        
        let restaurant = CLLocationCoordinate2D(
            latitude: 51.449532,
            longitude: -2.589309
        )
        
        let mapItem = try await locationService.findNearestMapItem(at: restaurant)
        
        #expect(mapItem != nil)
    }
}
