//
//  DateExtensionTests.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import XCTest
@testable import Footprints

final class DateExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func assertBetweenDates(_ date: Date, between start: Date, and end: Date, _ message: String = "") {
        
        if end < start {
            XCTAssertGreaterThanOrEqual(date, end, message)
            XCTAssertLessThanOrEqual(date, start, message)
        } else {
            XCTAssertGreaterThanOrEqual(date, start, message)
            XCTAssertLessThanOrEqual(date, end, message)
        }
     
        
    }

    func testDateString_whenGettingDateString_returnsASringThatMatchesTheDate() {
        let date = Date.now
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        let testDateString = date.dateString()
        
        XCTAssertEqual(testDateString, dateString, "when converting a date to string the string date should be the same as the date ")
    }
    
    func testDate_whenParsingDateString_returnsDateThatMatchesTheDateString() {
        // if
        let dateString = "2023-10-10 00:00:00"
        let format = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)!
        
        // when
        let testDate = Date.from(string: dateString, format: format)
        
        // then
        XCTAssertEqual(testDate, date, "when converting a string to a date the date should be the same as the date string")
    }
    
    func testDate_RandomDate_returnsARandomDate() {
        // if
        let startDate = Date.from(string: "2023-01-01 00:00:00")
        let endDate = Date.from(string: "2023-01-31 00:00:00")
        
        // when
        let randomDate = Date.randomBetween(start: startDate, end: endDate)
        
        // then

        
        
        XCTAssertGreaterThanOrEqual(randomDate, startDate, "Random date: \(randomDate), should be greater than or equal to start date: \(startDate)")
        XCTAssertLessThanOrEqual(randomDate, endDate, "Random date: \(randomDate), should be less than or equal to end date: \(endDate)")
    }
    
    func testDate_RandomDateWithEndDateBeforeStartDate_returnsARandomDate() {
        // if
        let startDate = Date.from(string: "2023-01-31 00:00:00")
        let endDate = Date.from(string: "2023-01-01 00:00:00")
        
        // when
        let randomDate = Date.randomBetween(start: startDate, end: endDate)
        
        // then
        XCTAssertGreaterThanOrEqual(randomDate, endDate, "Random date: \(randomDate), should be greater than or equal to end date: \(endDate)")
        XCTAssertLessThanOrEqual(randomDate, startDate, "Random date: \(randomDate), should be less than or equal to start date: \(startDate)")
    }
    
    func testDate_RandomDateWithShortDateRange_returnsARandomDate() {
        // if
        let startDate = Date.from(string: "2023-01-01 00:00:00")
        let endDate = Date.from(string: "2023-01-02 00:00:00")
        
        // when
        let randomDate = Date.randomBetween(start: startDate, end: endDate)
        
        // then
        XCTAssertGreaterThanOrEqual(randomDate, startDate, "Random date: \(randomDate), should be greater than or equal to start date: \(startDate)")
        XCTAssertLessThanOrEqual(randomDate, endDate, "Random date: \(randomDate), should be less than or equal to end date: \(endDate)")
    }
    
    func testDate_RandomDateWithSameStartAndEndDate_returnsARandomDate() {
        // if
        let startDate = Date.from(string: "2023-01-01 00:00:00")
        let endDate = Date.from(string: "2023-01-01 00:00:00")
        
        // when
        let randomDate = Date.randomBetween(start: startDate, end: endDate)
        
        // then
        assertBetweenDates(randomDate, between: startDate, and: endDate)
        
        XCTAssertGreaterThanOrEqual(randomDate, startDate, "Random date: \(randomDate), should be greater than or equal to start date: \(startDate)")
        XCTAssertLessThanOrEqual(randomDate, endDate, "Random date: \(randomDate), should be less than or equal to end date: \(endDate)")
    }
    
    func testDate_RandomDateWithDistantPast_returnsARandomDate() {
        // if
        let startDate = Date.distantPast
        let endDate = Date.now
        
        // when
        let randomDate = Date.randomBetween(start: startDate, end: endDate)
        
        // then
        XCTAssertGreaterThanOrEqual(randomDate, startDate, "Random date: \(randomDate), should be greater than or equal to start date: \(startDate)")
        XCTAssertLessThanOrEqual(randomDate, endDate, "Random date: \(randomDate), should be less than or equal to end date: \(endDate)")
    }
    
    func testDate_RandomDateWithDistantFuture_returnsARandomDate() {
        // if
        let startDate = Date.now
        let endDate = Date.distantFuture
        
        // when
        let randomDate = Date.randomBetween(start: startDate, end: endDate)
        
        // then
        XCTAssertGreaterThanOrEqual(randomDate, startDate, "Random date: \(randomDate), should be greater than or equal to start date: \(startDate)")
        XCTAssertLessThanOrEqual(randomDate, endDate, "Random date: \(randomDate), should be less than or equal to end date: \(endDate)")
    }
    
    func testDate_RandomDate_returnsARandomDateParametrized() {
        let testArray = [
            [Date.from(string: "2023-01-31 00:00:00"), Date.from(string: "2023-01-01 00:00:00"),
             "Should return a date"],
            
            [Date.from(string: "2023-01-31 00:00:00"), Date.from(string: "2023-01-01 00:00:00"),
             "Should return a date even if end date is earlier than the start date"],
            
            [Date.from(string: "2023-01-01 00:00:00"), Date.from(string: "2023-01-02 00:00:00"),
             "Should return a date even with a short date range"],
            
            [Date.from(string: "2023-01-01 00:00:00"), Date.from(string: "2023-01-01 00:00:00"),
             "Should return a date even with the same start and end dates"],
            
            [Date.distantPast, Date.now,
             "Should return a date even when the start date is in the distant past"],
            
            [Date.now, Date.distantFuture,
             "Should return a date even when the end date is in the distant future"],
            
        ]
        
        for test in testArray {
            let randomDate = Date.randomBetween(start: test[0] as! Date, end: test[1] as! Date)
            
            assertBetweenDates(randomDate, between: test[0] as! Date, and: test[1] as! Date, test[2] as! String)
            
        }
    }
}
