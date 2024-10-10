//
//  UITestHelpers.swift
//  FootprintsUITests
//
//  Created by Jill Allan on 06/10/2024.
//

import Foundation
import XCTest

struct UITestHelpers {
    func openTrip(app: XCUIApplication) {
        let tripButton = app.buttons["Bedminster to Beijing, 28 July 2016"]
        XCTAssertTrue(tripButton.isHittable)

        tripButton.tap()
    }

    func getMapCentreCoordinates(app: XCUIApplication) -> CGPoint {
        let mapFrame = app.descendants(matching: .map).firstMatch.frame

        let predicate = NSPredicate(format: "label CONTAINS 'Legal'")
        let legalLink = app.links.element(matching: predicate).firstMatch
        XCTAssert(legalLink.exists)

        let navBar = app.navigationBars.firstMatch

        let mapMidX = mapFrame.midX
        let mapMidY = ((legalLink.frame.minY - navBar.frame.maxY) / 2) + navBar.frame.maxY
        return CGPoint(x: mapMidX, y: mapMidY)
    }
    
    func getFirstElementDisplayedIn(scrollView: XCUIElement, with identifier: String) -> XCUIElement? {
        let elements = scrollView
            .descendants(matching: .button).matching(identifier: identifier)
        
        for i in 0..<elements.count {
            let element = elements.element(boundBy: i)
            if element.isHittable {
                return element
            }
        }
        return nil
    }
}
