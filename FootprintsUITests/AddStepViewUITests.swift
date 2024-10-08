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
    
    func testAddStepView_whenUserClicksOnMapToSelectLocation_LocationAppearsInSummary() throws {
        
        helper.openTrip(app: app)
        app.navigationBars["Steps"].buttons["Add step on map"].tap()
        let coordinates = helper.getMapCentreCoordinates(app: app)
    
        let centreOfMap = app
            .coordinate(withNormalizedOffset: CGVector.zero)
            .withOffset(CGVector(dx: coordinates.x, dy: coordinates.y))
       
        centreOfMap.tap()
    
        XCTAssert(app.staticTexts["River Thames"].exists)

    }
    
    func testAddStepView_whenUserScrollsToStepThenAddsStep_stepIsPopulatedWithScrolledToStep() throws {
        helper.openTrip(app: app)
        let scrollView = app.scrollViews.matching(identifier: "Trip Activity").firstMatch
        let firstDisplayedRow = helper.getFirstElementDisplayedIn(scrollView: scrollView, with: "Step")
        
        print("here is the first row")
        print(firstDisplayedRow?.label ?? "No row")
        
        print(app.debugDescription)
    
      
    }
    
    func testSomething() throws {
        helper.openTrip(app: app)
        let scrollView = app
            .scrollViews
            .matching(identifier: "Trip Activity")
            .firstMatch

        scrollView.swipeUp(velocity: 100)
        
        if let stepRow = helper.getFirstElementDisplayedIn(
            scrollView: scrollView,
            with: "Step"
        ) {
            
            XCTAssertTrue(stepRow.isHittable)
            
            let stepRowTimestamp = stepRow.staticTexts.element(boundBy: 1).label
            let dateTimeArray = stepRowTimestamp.components(separatedBy: " at ")
            let date = dateTimeArray[0]
            let time = dateTimeArray[1]
            print("dateTime: \(dateTimeArray)")
            
            let addButton = app.navigationBars.buttons["Add Step"]
            XCTAssertTrue(addButton.isHittable)
            addButton.tap()
            sleep(2)
            print(app.debugDescription)
            
            let datePicker = app.datePickers.element(boundBy: 0)
            try print("date picker: \(datePicker.snapshot())")
            
            let newStepTime = app
                .datePickers
                .element(boundBy: 0)
                .buttons.firstMatch
                .buttons.element(boundBy: 1).label
            let newStepDate = app
                .datePickers
                .element(boundBy: 0)
                .buttons.firstMatch
                .buttons.element(boundBy: 0).label
            
            XCTAssertEqual(date, newStepDate)
            XCTAssertEqual(time, newStepTime)
            
        }
        
        
        
        
    }

    
    func testSomethingElse() throws {
        helper.openTrip(app: app)
        let stepRow = app
            .scrollViews
            .matching(identifier: "Trip Activity")
            .firstMatch
            .children(matching: .button)
            .element(boundBy: Int.random(in: 0..<5))
        
        XCTAssertTrue(stepRow.isHittable)
        let stepRowTimestamp = stepRow.staticTexts.element(boundBy: 1).label
        let dateTimeArray = stepRowTimestamp.components(separatedBy: " at ")
        let date = dateTimeArray[0]
        let time = dateTimeArray[1]
        print("dateTime: \(dateTimeArray)")
        stepRow.tap()
        
        
        
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
