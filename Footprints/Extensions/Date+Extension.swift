//
//  Date+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation

extension Date {
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> Date {
        let startDate = Date.from(string: start, format: format)
        let endDate = Date.from(string: end, format: format)
        return Date.randomBetween(start: startDate, end: endDate)
    }

    static func randomBetween(start: Date, end: Date) -> Date {
        var earlistDate = Date()
        var latestDate = Date()

        if start == end {
            return start
        }

        if end < start {
            earlistDate = end
            latestDate = start
        } else {
            earlistDate = start
            latestDate = end
        }

        let span = TimeInterval.random(in: earlistDate.timeIntervalSinceNow...latestDate.timeIntervalSinceNow)

        return Date(timeIntervalSinceNow: span)
    }

    func dateString(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    /// Creates a date from a string
    /// - Parameters:
    ///   - string: A date represented by a string
    ///   - format: The format the string should be in, default is yyyy-MM-dd HH:mm:ss
    /// - Returns: A date
    ///
    /// Calling the function with the default format
    /// ```swift
    /// Date.from(string: "2024-01-01 12:00:00")
    /// ```
    ///
    /// Passing a custom format
    /// ```swift
    /// Date.from(string: "2024-01-01", format: "yyyy-MM-dd")
    /// ```
    static func from(string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}
