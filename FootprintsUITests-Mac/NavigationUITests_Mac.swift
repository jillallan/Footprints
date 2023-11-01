//
//  FootprintsUITests_Mac.swift
//  FootprintsUITests-Mac
//
//  Created by Jill Allan on 28/10/2023.
//

import XCTest

final class NavigationUITests_Mac: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testContentView_whenViewLoadsOnmacOS_sidebarButtonShouldBeHittable() throws {
        let sidebar = app.buttons["Hide Sidebar"]
        XCTAssert(sidebar.exists)

    }
    
    func testContentView_whenViewLoadsOnIpad_sidebarButtonShouldBeHittable() {
        let sidebarToggleButton = app/*@START_MENU_TOKEN@*/.windows["Footprints.ContentView-1-AppWindow-1"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.toolbars.children(matching: .button)["Hide Sidebar"]
        XCTAssert(sidebarToggleButton.isHittable)
//        .click()
        
    }
}
