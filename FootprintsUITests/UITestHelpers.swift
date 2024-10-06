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
        let tripButton = app.buttons["Bedminste to Beijing, 28 July 2016"]
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
}
