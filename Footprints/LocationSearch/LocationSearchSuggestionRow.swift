//
//  LocationSearchSuggestionRow.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import MapKit
import SwiftUI

struct LocationSearchSuggestionRow: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismissSearch) private var dismissSearch
    @Binding var dismissSearchView: Bool
    @Bindable var step: Step
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(mapItem.placemark.name ?? "No title")
                    .font(.headline)
                Text(mapItem.placemark.subtitle ?? "No subtitle")
                    .font(.subheadline)
            }
            Spacer()
            Button("Add") {
                print("Add button pressed")
                addLocation(to: step)
                dismissSearch()
                dismissSearchView.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
    
    func addLocation(to step: Step) {
        let newLocation = Location(cLPlacemark: mapItem.placemark)
        modelContext.insert(newLocation)
        step.location = newLocation
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        LocationSearchSuggestionRow(dismissSearchView: .constant(false), step: Step.stJohnsLane, mapItem: Step.stJohnsLane.mapItem)
    }
}
