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

    @State var aspectRatio: AspectRatioTest = .zero(AspectRatio: 0.0)
    @State var width: CGFloat = .zero
    @State var height: CGFloat = .zero
    
    var body: some View {
//        let _ = print("aspect ration nav stack: \(aspectRatio)")
        let _ = print("aspect ratio: \(aspectRatio)")
        let _ = print("width: \(width)")
        let _ = print("height: \(height)")
        
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
            }
            .sheet(isPresented: $isAddTripViewPresented) {
                AddTripView(navigationPath: $navPath)
            }
        }
        .getAspectRatio($aspectRatio)
        .getWidth($width)
        .getHeight($height)
        .environment(\.aspectRatio, aspectRatio)
        
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
