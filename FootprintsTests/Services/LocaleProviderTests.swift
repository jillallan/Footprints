//
//  LocaleProviderTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 23/03/2024.
//

import CoreLocation
import XCTest
@testable import Footprints

final class LocaleProviderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_localeProvided_getLocale_returnsALocale() async throws {

        // when
        let locale = LocaleProvider.getLocale()
        
        // then
        XCTAssertEqual(locale, "United Kingdom")
    }
    
    func test_localeProvider_loadRegionCoordinates_returnsListOfRegions() {
        
        // when
        let regions = LocaleProvider.regionsCoordinates
        print(LocaleProvider.regionsCoordinates)
        
        // then
        XCTAssertEqual(regions.count, 244)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
