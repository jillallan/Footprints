//
//  Date+Extension.swift
//  Journal
//
//  Created by Jill Allan on 11/10/2023.
//

import Foundation

extension Date {
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let startDate = Date.from(string: start, format: format)
        let endDate = Date.from(string: end, format: format)
        return Date.randomBetween(start: startDate, end: endDate).dateString(format)
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
    
    static func from(string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
}
