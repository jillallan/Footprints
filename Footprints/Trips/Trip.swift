//
//  Trip.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftData
import SwiftUI

@Model
final class Trip {
    // MARK: - Properties
    var title: String
    var startDate: Date
    var endDate: Date
    
    // MARK: - Computed Properties
    var debugDescription: String {
        "Trip named: \(title)"
    }
    
    // MARK: - Initialization
    init(title: String = "New Trip", startDate: Date = .now, endDate: Date = .now) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}
