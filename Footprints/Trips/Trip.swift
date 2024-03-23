//
//  Trip.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import MapKit
import OSLog
import SwiftData
import SwiftUI

@Model
final class Trip: CustomDebugStringConvertible {
    
    // MARK: - Properties
    var title: String
    var startDate: Date
    var endDate: Date
    var isAutoTrackingOn: Bool
    
    var steps: [Step]?
    
    // MARK: - Computed Properties
    var debugDescription: String {
        "Trip: \(title), start date: \(startDate), end date: \(endDate), tracking: \(isAutoTrackingOn), step count: \(String(describing: steps?.count))"
    }
    
    var tripSteps: [Step] {
        steps?.sorted() ?? []
    }
    
    var tripCentreCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D.centre(of: tripSteps.map(\.coordinate)) ?? CLLocationCoordinate2D.example
    }
    
    var tripCoordinateSpan: MKCoordinateSpan {
        MKCoordinateSpan.span(of: tripSteps.map(\.coordinate), padding: 0.1) ?? MKCoordinateSpan.example
    }
    
    var tripRegion: MKCoordinateRegion {
//        logger.debug("\(self.tripSteps.map(\.coordinate))")
        let region = MKCoordinateRegion.calculateRegion(from: tripSteps.map(\.coordinate), padding: 0.001)
//        logger.debug("\(String(describing: region))")
        
        return region
    }
    
    var tripIsLive: Bool {
        if (Date.now >= startDate && Date.now <= endDate) {
            return true
        } else {
            return false
        }
    }
    
    var tripDates: String {
        let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)

        var datesString = ""
        
        
        
        if let startDay = startDateComponents.day,
           let endDay = endDateComponents.day,
           let startMonth = startDateComponents.month,
           let endMonth = endDateComponents.month,
           let startYear = startDateComponents.year,
           let endYear = endDateComponents.year {
            
            if startYear == endYear {
                datesString.append(String(startYear))
            } else {
                datesString.append(String(startYear) + " - " + String(endYear))
            }
            
            if startMonth == endMonth {
                let month = "hello" //String(startMonth)
                let sss = ""
//                sss.insert("mm", at: month.startIndex)
            } else {
                datesString.append(String(startMonth) + " - " + String(endMonth))
            }
            
            if startDay == endDay {
                datesString.append(String(startDay))
            } else {
                datesString.append(String(startDay) + " - " + String(endDay))
            }
        }
        
        
        
        return ""
    }
    
    // MARK: - Initialization
    init(title: String = "New Trip", startDate: Date = .now, endDate: Date = .now, isAutoTrackingOn: Bool = false) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAutoTrackingOn = isAutoTrackingOn
    }
}
