//
//  LocationSuggestion.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import Foundation

struct LocationSuggestion: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String

    var mapItemSearchTerm: String {
        if subtitle.contains("Nearby") {
            return title
        } else {
            return "\(title) \(subtitle)"
        }
    }
}
