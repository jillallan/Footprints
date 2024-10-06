//
//  AddStepViewUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 06/10/2024.
//

import XCTest

final class AddStepViewUITests: XCTestCase {
    var app: XCUIApplication!
    var helper: UITestHelpers!

    override func setUpWithError() throws {
        app = XCUIApplication()
        helper = UITestHelpers()
        app.launch()

        let tripsNavigationBar = app.navigationBars["Trips"]
        tripsNavigationBar/*@START_MENU_TOKEN@*/.buttons["Clear"]/*[[".otherElements[\"Clear\"].buttons[\"Clear\"]",".buttons[\"Clear\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tripsNavigationBar/*@START_MENU_TOKEN@*/.buttons["SAMPLES"]/*[[".otherElements[\"SAMPLES\"].buttons[\"SAMPLES\"]",".buttons[\"SAMPLES\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
                
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testExampleTwo() throws {
        
        helper.openTrip(app: app)
        app.navigationBars["Steps"].buttons["Add step on map"].tap()
        let coordinates = helper.getMapCentreCoordinates(app: app)
    
//        let testCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: coordinates.x, dy: coordinates.y))
        let centreOfMap = app.coordinate(withNormalizedOffset: CGVector.zero).withOffset(CGVector(dx: coordinates.x, dy: coordinates.y))
       
        centreOfMap.tap()
    
        XCTAssert(app.staticTexts["River Thames"].exists)

        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
