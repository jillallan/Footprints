//
//  ExampleUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 02/10/2024.
//

import XCTest

final class ExampleUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
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
        
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        scrollViewsQuery.otherElements.buttons["Bedminste to Beijing, 28 July 2016"].tap()
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeUp()

        

        

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testExampleTwo() throws {

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let tripButton = elementsQuery.buttons["Bedminste to Beijing, 28 July 2016"]

        XCTAssertTrue(tripButton.isHittable)
        tripButton.tap()

        print(app.debugDescription)

//        let predicate = NSPredicate(format: "identifier CONTAINS 'AnnotationContainer'")
//        let mapAnnotationContainer = app.descendants(matching: .other).matching(predicate).firstMatch

        let mapAnnotationContainer = app.otherElements.element(matching: .other, identifier: "AnnotationContainer")
        print("map annotation debug")
        print(mapAnnotationContainer.debugDescription)
        let mapAnnotationContainerChildren = mapAnnotationContainer.descendants(matching: .other)
        print("annotation count \(mapAnnotationContainerChildren.count)")
//        XCTAssert(mapAnnotationContainer.children(matching: .other).count == 5)
        let mapAnnotation = mapAnnotationContainer.children(matching: .other).element(boundBy: 0)
        print("label")
        print("label: \(mapAnnotation.label)")

        XCTAssertTrue(mapAnnotation.isHittable)
        mapAnnotation.tap()



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
