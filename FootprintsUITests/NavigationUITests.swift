//
//  FootprintsUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 27/10/2023.
//

import XCTest

final class NavigationUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContentView_whenViewLoadsOnPhoneOrTV_tabbarShouldBeHittable() throws {
//#if (iOS)
        if (UIDevice.current.userInterfaceIdiom == .phone || UIDevice.current.userInterfaceIdiom == .tv) {
            let tabBar = app.tabBars.firstMatch
            XCTAssert(tabBar.isHittable)
        }
//#endif
    }
    
    func testContentView_whenViewLoadsOnIpad_sidebarButtonShouldBeHittable() throws {
//#if (iOS)
        if (UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad) {
            let sidebar = app.navigationBars.buttons["ToggleSidebar"] //.element(matching: .button, identifier: "ToggleSidebar")
            XCTAssert(sidebar.isHittable)
        }
//#elseif os(macOS)
        let sidebar = app.buttons["Hide Sidebar"]
        XCTAssert(sidebar.exists)
//#endif
    }


//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
