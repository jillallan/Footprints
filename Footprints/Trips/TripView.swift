//
//  TripView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftData
import SwiftUI

struct TripView: View {
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @Query var trips: [Trip]
    
    // MARK: - Navigation Properties
    @State var navPath = NavigationPath()
    @State private var isAddTripViewPresented: Bool = false
    
    // MARK: - View
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(trips) { trip in
                    NavigationLink(value: trip) {
                        Text(trip.title)
                    }
                }
            }
            
            // MARK: - Navigation
            .navigationTitle(AppScreen.trips.rawValue.capitalized)
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip, navigationPath: $navPath)
            }
            
            .sheet(isPresented: $isAddTripViewPresented) {
                AddTripView(navigationPath: $navPath)
            }
            
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add trip", systemImage: "plus") {
                        isAddTripViewPresented.toggle()
                    }
                }
            }
            
            // MARK: - Debug
            .toolbar {
                #if DEBUG
                ToolbarItem {
                    Button("Samples") {
                        Task {
                            await createData()
                        }
                    }
                }
                #endif
            }
        }
    }
   
#if DEBUG
    func createData() async {
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
    }
#endif
}

// MARK: - Preview
#Preview {
    NavigationStack {
        TripView()
            .modelContainer(SampleContainer.sample())
    }
}

#Preview("iPad") {

    NavigationSplitView {
        AppSidebarList(selection: .constant(AppScreen.trips))
    } detail: {
        NavigationStack {
            TripView()
                .modelContainer(SampleContainer.sample())
        }
    }
}
