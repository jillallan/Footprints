//
//  TestMapItemSearchService.swift
//  FootprintsTests
//
//  Created by Jill Allan on 10/10/2024.
//

import Testing
import MapKit
@testable import Footprints

struct TestMapItemSearchService {

    @Test func testMapItemSearchService_whenSearchingForLocation_returnsListOfMapItems() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let mapItemSearchService = MapItemSearchService()
        
        let searchTerm = "London"
        let mapItems = await mapItemSearchService.search(for: searchTerm, in: MKCoordinateRegion.defaultRegion())
        mapItems.map { mapItem in
            print(mapItem.name)
        }
        #expect(mapItems.count > 0)
    }
    
    @Test func testMapItemSearchService_whenSearchingForLocation_returnsMapItem() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let mapItemSearchService = MapItemSearchService()
        
        let searchTerm = "London"
        let mapItems = await mapItemSearchService.search(for: searchTerm, in: MKCoordinateRegion.defaultRegion())
        
        let mapItem = try #require(mapItems.first)
        
        #expect(mapItem.name == "London")
    }

}
