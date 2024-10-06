//
//  Tabs.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation

enum Tabs: Equatable, Hashable, Identifiable {
    case trips
    case steps
    case locations

    var id: Int {
        switch self {
        case .trips: 1001
        case .steps: 1002
        case .locations: 1003
        }
    }

    var name: String {
        switch self {
        case .trips: String(localized: "Trips", comment: "Tab title")
        case .steps: String(localized: "Steps", comment: "Tab title")
        case .locations: String(localized: "Locations", comment: "Tab title")
        }
    }

    var symbol: String {
        switch self {
        case .trips: "suitcase"
        case .steps: "shoe"
        case .locations: "location"
        }
    }
}
