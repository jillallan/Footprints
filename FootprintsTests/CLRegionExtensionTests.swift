//
//  TestCLCircularRegionExtension.swift
//  FootprintsTests
//
//  Created by Jill Allan on 18/10/2024.
//

import MapKit
import Testing
@testable import Footprints

struct TestCLCircularRegionExtension {

    @Test func testGetRegionRadius() async throws {
//        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1277), radius: 998.5, identifier: "Test")
        
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: 0.0))
        
        let mapItemIdentifer = try #require(MKMapItem.Identifier(rawValue: "I40C324BAAE43A8EB"))
        let mapItemRequest = MKMapItemRequest(mapItemIdentifier: mapItemIdentifer)
        let mapItem = try await mapItemRequest.mapItem
        
        
        let region = try #require(mapItem.placemark.region)
        print(region)
        
        let radius = CLRegion.getRadius(from: region)
        
        #expect(radius == 154.41)
    }

}
