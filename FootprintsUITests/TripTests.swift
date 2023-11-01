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
        window = app/*@START_MENU_TOKEN@*/.windows["Trips"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
#endif
        continueAfterFailure = false

    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTripView_whenAddTripButtonTapped_BringsUpAddTripSheet() {
        let addTripButton = app.buttons["Add trip"].firstMatch
        
        XCTAssert(addTripButton.isHittable)
        addTripButton.tap()

        let addTripNavigationTitle = app.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }
    
    func testAddTripView_whenSaveButtonPressed_SavesTripAndOpensTripDetailView() throws {
        let title = "Hello"
       
        addTrip(title: title, startDate: .now, endDate: .distantFuture)
    }
    
    func addTrip(title: String, startDate: Date, endDate: Date) {
        // launch add trip sheet
        testTripView_whenAddTripButtonTapped_BringsUpAddTripSheet()

        // get title text view, check it exists, tap to give it focus
        // and enter title
        let titleTextField = app.textViews["Title"]
        XCTAssert(titleTextField.isHittable)
        titleTextField.tap()
        titleTextField.typeText(title)
        
        // get startDatePicker, check it exists, tap to open it
//        let startDatePicker = app.datePickers.element(boundBy: 0)
//        XCTAssert(startDatePicker.isHittable)
//        startDatePicker.tap()
//        
//        pickDate(app: app, newDate: startDate)
//        
//        // get endDatePicker, check it exists, tap to open it
//        let endDatePicker = app.datePickers.element(boundBy: 1)
//        XCTAssert(endDatePicker.isHittable)
//        endDatePicker.tap()
//
//        pickDate(app: app, newDate: startDate)
    }
}
