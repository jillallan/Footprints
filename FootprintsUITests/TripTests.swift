//
//  TripTests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 27/10/2023.
//

import XCTest

final class TripTests: XCTestCase {
    var app: XCUIApplication!
    var window: XCUIElement!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
#if os(iOS)
        window = app.windows.firstMatch
#elseif os(macOS)
        window = app/*@START_MENU_TOKEN@*/.windows["Footprints.ContentView-1-AppWindow-1"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
#endif
        continueAfterFailure = false

    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddTripButton_whenTappedOrClicked_BringsUpAddTripSheet() throws {
        let addTripButton = app.buttons["Add trip"].firstMatch
        
#if os(iOS)
        
        XCTAssert(addTripButton.isHittable)
        addTripButton.tap()
#elseif os(macOS)

        XCTAssert(addTripButton.exists)
        addTripButton.click()
#endif

        let addTripNavigationTitle = app.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }
}
