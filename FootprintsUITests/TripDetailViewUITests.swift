//
//  FootprintsUITests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 09/08/2024.
//

import XCTest

final class TripDetailViewUITests: XCTestCase {
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

    func openTrip() {
        let tripButton = app.buttons["Bedminste to Beijing, 28 July 2016"]
        XCTAssertTrue(tripButton.isHittable)

        tripButton.tap()
    }

    func getMapCentreCoordinates() -> CGPoint {
        let mapFrame = app.descendants(matching: .map).firstMatch.frame

        let predicate = NSPredicate(format: "label CONTAINS 'Legal'")
        let legalLink = app.links.element(matching: predicate).firstMatch
        XCTAssert(legalLink.exists)

        let navBar = app.navigationBars.firstMatch

        let mapMidX = mapFrame.midX
        let mapMidY = ((legalLink.frame.minY - navBar.frame.maxY) / 2) + navBar.frame.maxY
        print("map centre x \(mapMidX)")
        print("map centre y \(mapMidY)")
        return CGPoint(x: mapMidX, y: mapMidY)
    }

    // VKPointFeature identifier for MKMapItem

    @MainActor
    func testAllAnnotationsDisplayWhenTripOpens() throws {

        openTrip()
        let mapAnnotationContainer = app.otherElements.element(matching: .other, identifier: "AnnotationContainer")
        let mapAnnotationsCount = mapAnnotationContainer.children(matching: .other).count

        XCTAssertEqual(mapAnnotationsCount, 9)

    }

    @MainActor
    func testScrollsToStepWhenSelectedOnMap() throws {

        openTrip()
        let mapAnnotationContainer = app.otherElements.element(matching: .other, identifier: "AnnotationContainer")
        let mapAnnotation = mapAnnotationContainer.children(matching: .other).element(boundBy: Int.random(in: 0..<8))
        XCTAssert(mapAnnotation.isHittable)
        mapAnnotation.tap()
        sleep(2)

//        let label = mapAnnotation.label
//        let predicate = NSPredicate(format: "label CONTAINS %@", mapAnnotation.label)
        let stepScrollView = app.descendants(matching: .scrollView).firstMatch
        let scrollViewViews = stepScrollView.descendants(matching: .button).descendants(matching: .staticText)

        for i in 0..<scrollViewViews.count {
            let stepRow = scrollViewViews.element(boundBy: i)
            if stepRow.isHittable {
                XCTAssertEqual(stepRow.label, mapAnnotation.label)
            }

            if stepRow.isHittable {
                break
            }
        }
        
    }

    @MainActor
    func testThis() throws {

        openTrip()

        let stepScrollView = app.descendants(matching: .scrollView).firstMatch
        XCTAssertTrue(stepScrollView.exists)
        stepScrollView.swipeUp(velocity: 100)

        print(app.debugDescription)
        let scrollViewViews = stepScrollView.descendants(matching: .button).descendants(matching: .staticText)

        for i in 0..<scrollViewViews.count {
            let stepRow = scrollViewViews.element(boundBy: i)
            if stepRow.isHittable {

                let mapAnnotationContainer = app.otherElements.element(matching: .other, identifier: "AnnotationContainer")
                let predicate = NSPredicate(format: "label CONTAINS %@", stepRow.label)
                let mapAnnotation = mapAnnotationContainer.children(matching: .other).matching(predicate).firstMatch


                XCTAssertTrue(mapAnnotation.isHittable)
                XCTAssertEqual(mapAnnotation.label, stepRow.label)

                let mapCentreCoordinates = getMapCentreCoordinates()

                XCTAssertEqual(mapCentreCoordinates.x, mapAnnotation.frame.midX, accuracy: 1.0)

                if stepRow.isHittable {
                    break
                }
            }
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
