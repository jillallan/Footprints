//
//  FootprintsUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 09/08/2024.
//

import XCTest

final class TripDetailViewUITests: XCTestCase {
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

    // VKPointFeature identifier for MKMapItem

    @MainActor
    func testAllAnnotationsDisplayWhenTripOpens() throws {

        helper.openTrip(app: app)
        let mapAnnotationContainer = app.otherElements.element(matching: .other, identifier: "AnnotationContainer")
        let mapAnnotationsCount = mapAnnotationContainer.children(matching: .other).count
        sleep(1)
        XCTAssertEqual(mapAnnotationsCount, 9)

    }

    @MainActor
    func testTripDetailView_whenMapAnnotationSeelcted_ScrollsToStepInList() throws {

        helper.openTrip(app: app)
        let mapAnnotationContainer = app
            .otherElements
            .element(matching: .other, identifier: "AnnotationContainer")
        let mapAnnotation = mapAnnotationContainer
            .children(matching: .other)
            .element(boundBy: Int.random(in: 0..<8))
        XCTAssert(mapAnnotation.isHittable)
        let mapAnnotationLabel = mapAnnotation.label
        mapAnnotation.tap()
        
        sleep(3)
        
        let scrollView = app.scrollViews.matching(identifier: "Trip Activity").firstMatch
        let firstDisplayedRow = helper.getFirstElementDisplayedIn(scrollView: scrollView, with: "Step")
        
        if let firstDisplayedRow {
            let rowTitle = firstDisplayedRow
                .staticTexts
                .element(boundBy: 0)
            XCTAssert(rowTitle.exists)
            XCTAssertEqual(
                rowTitle.label,
                mapAnnotationLabel,
                "map annotation: \(mapAnnotationLabel) should equal label: \(rowTitle.label)"
            )
        }
    }

    @MainActor
    func testTripDetailView_whenScrollingStepList_movesToMapAnnotation() throws {

        helper.openTrip(app: app)
        
        let scrollView = app.scrollViews.matching(identifier: "Trip Activity").firstMatch
        XCTAssert(scrollView.exists)
        scrollView.swipeUp(velocity: 100)
        sleep(3)
        let firstDisplayedRow = helper.getFirstElementDisplayedIn(scrollView: scrollView, with: "Step")
        
        if let firstDisplayedRow {
            let rowTitle = firstDisplayedRow.staticTexts.element(boundBy: 0)
            
//            print(rowTitle.label)
            let mapAnnotationContainer = app.otherElements.element(matching: .other, identifier: "AnnotationContainer")
            let predicate = NSPredicate(format: "label CONTAINS %@", rowTitle.label)
            
            print(app.debugDescription)
            let mapAnnotation = mapAnnotationContainer.children(matching: .other).matching(predicate).firstMatch
            
            XCTAssertTrue(mapAnnotation.isHittable)
            XCTAssertEqual(mapAnnotation.label, firstDisplayedRow.label)
            
            let mapCentreCoordinates = helper.getMapCentreCoordinates(app: app)

            XCTAssertEqual(mapCentreCoordinates.x, mapAnnotation.frame.midX, accuracy: 1.0)
        }

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
