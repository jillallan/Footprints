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
    @Environment(LocationHandler.self) private var locationHandler
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
                .onDelete { indexSet in
                    deleteTrips(indexSet)
                }
            }
            
            // MARK: - Navigation
            .navigationTitle(AppScreen.trips.rawValue.capitalized)
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip, navigationPath: $navPath)
            }
            
//            .sheet(isPresented: $isAddTripViewPresented) {
//                AddTripView(navigationPath: $navPath)
//            }
            
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add trip", systemImage: "plus") {
//                        isAddTripViewPresented.toggle()
                        addTrip()
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
    
    func addTrip() {
        let newTrip = Trip()
        modelContext.insert(newTrip)
//        navPath.append(newTrip)
    }
    
    func deleteTrips(_ indexSet: IndexSet) {
        for index in indexSet {
            let trip = trips[index]
            modelContext.delete(trip)
        }
    }
   
#if DEBUG
    func createData() async {
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
//        locationHandler.enableLocationServices()
    }
#endif
}

// MARK: - Preview
#Preview {
    NavigationStack {
        TripView()
            .modelContainer(SampleContainer.sample())
            .environment(LocationHandler.preview)
    }
}

#Preview("iPad") {

    NavigationSplitView {
        AppSidebarList(selection: .constant(AppScreen.trips))
    } detail: {
        NavigationStack {
            TripView()
                .modelContainer(SampleContainer.sample())
                .environment(LocationHandler.preview)
        }
    }
}
