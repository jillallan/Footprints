//
//  TestLocationService.swift
//  FootprintsTests
//
//  Created by Jill Allan on 06/10/2024.
//

//import RealModule
import Testing
import CoreLocation
import MapKit
@testable import Footprints

struct TestLocationService {

    @Test func testLocationService_fetchPointOfInterestMapItems_returnsMapItems() async throws {
        let locationService = LocationService()
        let coordinate = CLLocationCoordinate2D(latitude: 51.440658, longitude: -2.593528)
        let mapItems = try await locationService.fetchPointOfInterestMapItems(for: coordinate)
        print(mapItems.debugDescription)
        #expect(mapItems.count > 0)
    }
    
    @Test func testLocationService_fetchMapItemsForCoordinate_returnsMapItems() async throws {
        let locationService = LocationService()
        let coordinate = CLLocationCoordinate2D(latitude: 51.440658, longitude: -2.593528)
        let mapItems = try await locationService.fetchMapItems(for: coordinate)
        print(mapItems.debugDescription)
        #expect(mapItems.count > 0)
    }
    
    
    @Test func testLocationService_createMapItemForCoordinate_returnsMapItem() async throws {
        let locationService = LocationService()
        let coordinate = CLLocationCoordinate2D(latitude: 51.440658, longitude: -2.593528)
        let mapItem = try await locationService.createMapItem(for: coordinate)
        let item = try #require(mapItem)
        print(item.debugDescription)
        #expect(item != nil)
    }
    
    @Test func testLocationService_chooseBestMapItem_returnsMapItem() async throws {
        let locationService = LocationService()
        let coordinate = CLLocationCoordinate2D(latitude: 51.439930, longitude: -2.595027)
        let mapItem = try await locationService.chooseBestMapItem(for: coordinate)
        let item = try #require(mapItem)
        print(item.debugDescription)
        #expect(item != nil)
    }
}
