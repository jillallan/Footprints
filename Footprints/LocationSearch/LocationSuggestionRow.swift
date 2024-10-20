//
//  LocationSuggestionRow.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import SwiftUI

struct LocationSuggestionRow: View {
    let locationSuggestion: LocationSuggestion
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(locationSuggestion.title)
                .font(.headline)
            Text(locationSuggestion.subtitle)
                .font(.subheadline)
        }
    }
}

#Preview {
    LocationSuggestionRow(locationSuggestion: LocationSuggestion(title: "London", subtitle: "England"))
}
