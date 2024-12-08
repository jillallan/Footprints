//
//  SearchSuggestionsList.swift
//  Footprints
//
//  Created by Jill Allan on 08/12/2024.
//

import MapKit
import SwiftUI

struct SearchSuggestionsList: View {
    @Binding var locationSuggestions: [LocationSuggestion]
    @Binding var selectedLocationSuggestion: LocationSuggestion?
    
    var body: some View {
        ForEach(locationSuggestions) { suggestion in
            Button {
                selectedLocationSuggestion = suggestion
            } label: {
                LocationSuggestionRow(locationSuggestion: suggestion)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    SearchSuggestionsList(locationSuggestions: .constant([]), selectedLocationSuggestion: .constant(nil))
}
