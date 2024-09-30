//
//  FootprintsUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 09/08/2024.
//

import XCTest

final class TripDetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // VKPointFeature identifier for MKMapItem

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
//        print(app.debugDescription)
        let tripButton = app.buttons["Bedminste to Beijing, 28 July 2016"]
        XCTAssertTrue(tripButton.isHittable)

        tripButton.tap()



//        let mapItems = app
//        XCTAssertTrue(map.exists)
        let mapPins = app.descendants(matching: .other).matching(identifier: "AnnotationContainer").children(matching: .other).count
        print("map pins: \(mapPins)")

        let mapPin = app.descendants(matching: .other).matching(identifier: "AnnotationContainer").children(matching: .other).firstMatch.frame
        print(mapPin.debugDescription)

        let mapFrame = app.descendants(matching: .map).firstMatch.frame
        print(mapFrame.debugDescription)

//        let scrollViewFrame = app.descendants(matching: .map).firstMatch.frame
        print(mapFrame.debugDescription)



        print("App info:")
        print(app.debugDescription)

//        let map = app.staticTexts["Map"]
//        XCTAssertTrue(map.exists)
//        print(app.debugDescription)

        XCTFail()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testThis() throws {
        
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
