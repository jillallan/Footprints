//
//  LocationView.swift
//  Footprints
//
//  Created by Jill Allan on 23/11/2024.
//

import SwiftData
import SwiftUI

struct LocationView: View {
    @Query private var locations: [Location]
    @State private var isEditLocationViewPresented: Location?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locations) { location in
                    Text(location.name)
                }
            }
            .navigationTitle(Tabs.locations.name)
        }
    }
}

#Preview(traits: .previewData) {
    NavigationStack {
        LocationView()
    }
}
