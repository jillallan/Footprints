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
//        let addTripButton = app.buttons["Add trip"].firstMatch
        let addTripButton = app/*@START_MENU_TOKEN@*/.windows["Trips"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.toolbars.children(matching: .button)["Add trip"]
        
        XCTAssert(addTripButton.isHittable)
        addTripButton.click()

        let addTripNavigationTitle = app.staticTexts["Add Trip"]
//        app.window["Trips"]app.sheets.staticTexts["Add Trip"]
        XCTAssert(addTripNavigationTitle.exists)
    }
    
    func testAddTripView_whenSaveButtonPressed_SavesTripAndOpensTripDetailView() throws {
        testTripView_whenAddTripButtonClicked_BringsUpAddTripSheet()
        let title = "Hello"
       
        let titleTextField = app/*@START_MENU_TOKEN@*/.windows["Trips"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.sheets/*@START_MENU_TOKEN@*/.groups/*[[".scrollViews.groups",".groups"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Title"]
        XCTAssert(titleTextField.isHittable)
        
        titleTextField.tap()
        titleTextField.typeText(title)
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let footprintsContentview1Appwindow1Window = app/*@START_MENU_TOKEN@*/.windows["Trips"]/*[[".windows[\"Trips\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        footprintsContentview1Appwindow1Window/*@START_MENU_TOKEN@*/.outlines["Sidebar"]/*[[".splitGroups[\"Footprints.ContentView-1-AppWindow-1, SidebarNavigationSplitView\"]",".groups",".scrollViews.outlines[\"Sidebar\"]",".outlines[\"Sidebar\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.children(matching: .outlineRow).element(boundBy: 1).cells.containing(.button, identifier:"Steps").element.click()
        
        let footprintsContentview1Appwindow1Window2 = app/*@START_MENU_TOKEN@*/.windows["Footprints.ContentView-1-AppWindow-1"]/*[[".windows[\"Footprints\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        footprintsContentview1Appwindow1Window2/*@START_MENU_TOKEN@*/.outlines["Sidebar"].buttons["Locations"]/*[[".splitGroups[\"Footprints.ContentView-1-AppWindow-1, SidebarNavigationSplitView\"]",".groups",".scrollViews.outlines[\"Sidebar\"]",".outlineRows",".cells.buttons[\"Locations\"]",".buttons[\"Locations\"]",".outlines[\"Sidebar\"]"],[[[-1,6,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,6,3],[-1,2,3],[-1,1,2]],[[-1,6,3],[-1,2,3]],[[-1,5],[-1,4],[-1,3,4]],[[-1,5],[-1,4]]],[0,0]]@END_MENU_TOKEN@*/.click()
        footprintsContentview1Appwindow1Window2/*@START_MENU_TOKEN@*/.outlines["Sidebar"].buttons["Trips"]/*[[".splitGroups[\"Footprints.ContentView-1-AppWindow-1, SidebarNavigationSplitView\"]",".groups",".scrollViews.outlines[\"Sidebar\"]",".outlineRows",".cells.buttons[\"Trips\"]",".buttons[\"Trips\"]",".outlines[\"Sidebar\"]"],[[[-1,6,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,6,3],[-1,2,3],[-1,1,2]],[[-1,6,3],[-1,2,3]],[[-1,5],[-1,4],[-1,3,4]],[[-1,5],[-1,4]]],[0,0]]@END_MENU_TOKEN@*/.click()
        
        let addTripButton = footprintsContentview1Appwindow1Window.toolbars.children(matching: .button)["Add trip"].children(matching: .button)["Add trip"]
        addTripButton.click()
        
        let tripsCell = footprintsContentview1Appwindow1Window/*@START_MENU_TOKEN@*/.outlines["Sidebar"].cells.containing(.button, identifier:"Trips").element/*[[".splitGroups[\"Footprints.ContentView-1-AppWindow-1, SidebarNavigationSplitView\"]",".groups",".scrollViews.outlines[\"Sidebar\"]",".outlineRows.cells.containing(.button, identifier:\"Trips\").element",".cells.containing(.button, identifier:\"Trips\").element",".outlines[\"Sidebar\"]"],[[[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/
        tripsCell.typeText("New Trip")
        
        let sheetsQuery = footprintsContentview1Appwindow1Window.sheets
        let saveButton = sheetsQuery/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".groups.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        saveButton.click()
        app/*@START_MENU_TOKEN@*/.windows["Footprints.ContentView-1-AppWindow-1"].toolbars.buttons["Back"]/*[[".windows[\"New Trip\"].toolbars",".groups.buttons[\"Back\"]",".buttons[\"Back\"]",".windows[\"Footprints.ContentView-1-AppWindow-1\"].toolbars"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.click()
        addTripButton.click()
        
        let titleTextField = sheetsQuery/*@START_MENU_TOKEN@*/.groups/*[[".scrollViews.groups",".groups"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.textFields["Title"]
        titleTextField.click()
        
        let scrollViewsQuery = sheetsQuery/*@START_MENU_TOKEN@*/.scrollViews/*[[".groups.scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        scrollViewsQuery/*@START_MENU_TOKEN@*/.groups.containing(.staticText, identifier:"Start Date").element/*[[".groups.containing(.staticText, identifier:\"End Date\").element",".groups.containing(.staticText, identifier:\"Start Date\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()
        scrollViewsQuery/*@START_MENU_TOKEN@*/.groups.containing(.staticText, identifier:"Start Date")/*[[".groups.containing(.staticText, identifier:\"End Date\")",".groups.containing(.staticText, identifier:\"Start Date\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .datePicker).element(boundBy: 0).steppers.children(matching: .incrementArrow).element.click()
        titleTextField.click()
        tripsCell.typeText("New Trip2")
        saveButton.click()
        
    }
}
