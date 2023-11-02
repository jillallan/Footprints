//
//  TripTests_Mac.swift
//  FootprintsUITests-Mac
//
//  Created by Jill Allan on 01/11/2023.
//

import XCTest

final class TripTests_Mac: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    func testTripView_whenAddTripButtonClicked_BringsUpAddTripSheet() {

        let addTripButton = app/*@START_MENU_TOKEN@*/.windows["Trips"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.toolbars.children(matching: .button)["Add trip"]
        
        XCTAssert(addTripButton.isHittable)
        addTripButton.click()

        let addTripNavigationTitle = app.staticTexts["Add Trip"]
//        app.window["Trips"]app.sheets.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }
    
    func testAddTripView_WhenSaveButtonPressed_MovesToTripDetailView() {
        
        testTripView_whenAddTripButtonClicked_BringsUpAddTripSheet()
        
        let title = String.randomWord()
        let startDate = Date.randomBetween(start: "2020-01-01", end: "2023-01-01", format: "yyyy-MM-dd")
        let endDate = Date.randomBetween(start: "2023-01-01", end: "2025-01-01", format: "yyyy-MM-dd")
        
        addTrip(title: title, startDate: startDate, endDate: endDate)
        
        let navigationBarTitle = app.windows[title].staticTexts[title]
        print(navigationBarTitle)
        
        XCTAssert(navigationBarTitle.exists)
    }
    
    func addTrip(title: String, startDate: Date, endDate: Date) {
        let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        let startDay = startDateComponents.day ?? 0
        let startMonth = startDateComponents.month ?? 0
        let startYear = startDateComponents.year ?? 0
        
        let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        let endDay = endDateComponents.day ?? 0
        let endMonth = endDateComponents.month ?? 0
        let endYear = endDateComponents.year ?? 0
        
        // Enter trip title
        let titleTextField = app/*@START_MENU_TOKEN@*/.windows["Trips"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.sheets/*@START_MENU_TOKEN@*/.groups/*[[".scrollViews.groups",".groups"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Title"]
        XCTAssert(titleTextField.isHittable)
        titleTextField.click()
        titleTextField.typeText(title)
      
        // Tab across to start date and enter start date
        // then tab to end date and enter end date
        
        titleTextField.typeText("\t\(startDay)\t\(startMonth)\t\(startYear)\t\(endDay)\t\(endMonth)\t\(endYear)")
        
        let saveButton = app.windows["Trips"].sheets/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".groups.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(saveButton.isHittable)
        saveButton.click()
        
    }

}
