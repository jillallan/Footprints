//
//  TripTests.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 27/10/2023.
//

import XCTest

final class TripTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTripView_whenAddTripButtonTapped_BringsUpAddTripSheet() {
        let addTripButton = app.buttons["Add trip"]
        
        XCTAssert(addTripButton.isHittable)
        addTripButton.tap()

        let addTripNavigationTitle = app.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }
    
    func testAddTripView_whenSaveButtonPressed_SavesTripAndOpensTripDetailView() throws {
        let title = String.randomWord()
        let startDate = Date.randomBetween(start: "2020-01-01", end: "2023-01-01", format: "yyyy-MM-dd")
        let endDate = Date.randomBetween(start: "2023-01-01", end: "2024-01-01", format: "yyyy-MM-dd")
       
        addTrip(title: title, startDate: startDate, endDate: endDate)

    }
    
    
    func addTrip(title: String, startDate: Date, endDate: Date) {
        // launch add trip sheet
        testTripView_whenAddTripButtonTapped_BringsUpAddTripSheet()
        let calendarPicker = CalendarPicker()

        // get title text view, check it exists, tap to give it focus
        // and enter title
        let titleTextField = app.textViews["Title"]
        XCTAssert(titleTextField.isHittable)
        titleTextField.tap()
        titleTextField.typeText(title)
        
        // get startDatePicker, check it exists, tap to open it
        let startDatePicker = app.datePickers.element(boundBy: 0)
        XCTAssert(startDatePicker.isHittable)
        startDatePicker.tap()
        
        calendarPicker.pickDate(app: app, newDate: startDate)
        
        // get endDatePicker, check it exists, tap to open it
        let endDatePicker = app.datePickers.element(boundBy: 1)
        XCTAssert(endDatePicker.isHittable)
        endDatePicker.tap()

        calendarPicker.pickDate(app: app, newDate: endDate)
        
        let ttt = app.cells.containing(NSPredicate(format: "label CONTAINS %@", "Start Date")).descendants(matching: .button).element.value
        let bbb = app.cells.containing(NSPredicate(format: "label CONTAINS %@", "End Date")).descendants(matching: .button).element.value 
        
        print("mmmm: \(String(describing: ttt)), \(String(describing: bbb))")
        if let startDatePickerValue = app.buttons["Date Picker"].firstMatch.value {
            XCTAssertEqual(startDatePickerValue as! String,  startDate.formatted(date: .abbreviated, time: .omitted), "message1")
        } else {
            XCTFail("message2")
        }
        
    }
}
