//
//  TripView2.swift
//  Footprints
//
//  Created by Jill Allan on 22/03/2024.
//

import SwiftUI
import SwiftData

struct TripView2: View {
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @Query var trips: [Trip]
    
    // MARK: - Navigation Properties
    @State var navPath = NavigationPath()
    @State var navigation = NavigationController()
    @State var isAddTripViewPresented: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigation.navigationPath) {
            List {
                ForEach(trips) { trip in
                    NavigationLink(value: trip) {
                        Text(trip.title)
                    }
                }
            }
            .navigationTitle("Trips")
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView2(trip: trip)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add trip", systemImage: "plus") {
                        isAddTripViewPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isAddTripViewPresented) {
//                AddTripView2(navPath: $navPath)
                AddTripView2()
            }
            .environment(navigation)
        }
    }
}

#Preview {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        TripView2()
    }
}
