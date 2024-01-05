//
//  TripView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftData
import SwiftUI

struct TripView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var trips: [Trip]
    @State var navPath = NavigationPath()
    
    @State private var isAddTripViewPresented: Bool = false
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack(path: $navPath) {
            List {
                ForEach(trips) { trip in
                    NavigationLink(value: trip) {
                        Text(trip.title)
                    }
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
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip, navigationPath: $navPath)
//                TripDetailViewSimple(path: $navPath, trip: trip)
            }
            
            .sheet(isPresented: $isAddTripViewPresented) {
                AddTripView(navigationPath: $navPath)
            }
        }
        .environment(\.navigationPath, navPath)
    }
        
#if DEBUG
    func createData() async {
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
    }
#endif
}

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
