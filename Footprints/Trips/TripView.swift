//
//  TripView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftData
import SwiftUI

struct TripView: View {
    @Query var trips: [Trip]
    @State var navPath = NavigationPath()
    
    @State private var isAddTripViewPresented: Bool = false
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(trips) { trip in
                    Text(trip.title)
                }
            }
            .navigationTitle(AppScreen.trips.rawValue.capitalized)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddTripViewPresented.toggle()
                    } label: {
                        Label("Add trip", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button("Samples") {
                        createData()
                    }
                }
            }
            .navigationDestination(for: Trip.self) { trip in
                
            }
            .sheet(isPresented: $isAddTripViewPresented) {
                AddTripView(navigationPath: $navPath)
            }
        }
    }
    func createData() {

    }
}

#Preview {
    NavigationStack {
        TripView()
            .modelContainer(for: Trip.self, inMemory: true)
    }
}
