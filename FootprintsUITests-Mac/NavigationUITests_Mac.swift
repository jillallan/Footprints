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
}
