//
//  Step.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import SwiftData
import SwiftUI

@Model
final class Step {
    // MARK: - Properties
    var timestamp: Date
    
    var trip: Trip?
    
    // MARK: - Initialization
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
