//
//  Trip.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

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
    
    var tripIsLive: Bool {
        if (Date.now >= startDate && Date.now <= endDate) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Initialization
    init(title: String = "New Trip", startDate: Date = .now, endDate: Date = .now, isAutoTrackingOn: Bool = false) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAutoTrackingOn = isAutoTrackingOn
    }
}
