//
//  DateFormatterExtensionTests.swift
//  FootprintsTests
//
//  Created by Jill Allan on 02/02/2024.
//

import XCTest

final class DateFormatterExtensionTests: XCTestCase {
    var date: Date!
    var year: Int!
    var month: Int!
    var day: Int!
    var hour: Int!
    var minute: Int!
    var second: Int!

    override func setUpWithError() throws {
        // if
        year = Int.random(in: 1990...2030)
        month = Int.random(in: 1...12)
        day = Int.random(in: 1...28)
        hour = Int.random(in: 1...24)
        minute = Int.random(in: 0...60)
        second = Int.random(in: 0...60)
        
        let dateComponents = DateComponents(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        )
        
        let calendar = Calendar(identifier: .gregorian)
        date = calendar.date(from: dateComponents)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_dateFromString_withDefaukltFormat_ReturnsDate() throws {

        //dateComponents.timeZone = TimeZone(abbreviation: "GMT") // Japan Standard Time
        // when
        let dateString = String(
            format: "%04d-%02d-%02d %02d:%02d:%02d",
            year, month, day, hour, minute, second
        )
        
        if let newDate = DateFormatter().date(from: dateString),
           let date {
            XCTAssertEqual(newDate, date)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
