//
//  LocationView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationView: View {
    @Query var locations: [Location]

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
    LocationView()
        .modelContainer(SampleContainer.sample())
}
