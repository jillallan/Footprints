//
//  PlacemarkView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct PlacemarkView: View {
    @Query var locations: [Placemark]

    var body: some View {
        NavigationStack{
            List {
                ForEach(locations) { location in
                    Text(location.name ?? "No location")
                }
            }
            .navigationTitle("Locations")
        }
    }
}

#Preview {
    PlacemarkView()
        .modelContainer(SampleContainer.sample())
}
