//
//  ExtensionTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 02/02/2024.
//

import CoreLocation
import XCTest
@testable import Footprints

final class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCentreOfCoordinates_withCoordinateArray_shouldReturnMeanOfCoordinates() throws {
        // if
        let coordinates = [
            CLLocationCoordinate2D(latitude: 1.1, longitude: 2.2),
            CLLocationCoordinate2D(latitude: 3.3, longitude: 4.4),
            CLLocationCoordinate2D(latitude: 5.5, longitude: 6.6),
            CLLocationCoordinate2D(latitude: 7.7, longitude: 8.8),
        ]
        
        let latitudeMidPoint = (7.7 - 1.1) / 2
        let longitudeMidPoint = (8.8 - 2.2) / 2
        
        // when
        let centre = CLLocationCoordinate2D.centre(of: coordinates)
        print(centre)
        
        //then
        XCTAssertEqual(centre, CLLocationCoordinate2D(latitude: latitudeMidPoint, longitude: longitudeMidPoint))
    }
}
