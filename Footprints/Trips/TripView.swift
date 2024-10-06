//
//  Trips.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import SwiftData
import SwiftUI

struct TripView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @EnvironmentObject var navigationController: NavigationController
    @Query(sort: \Trip.startDate, order: .forward) private var trips: [Trip]
    @Namespace var tripList

    private var columns: [GridItem] {
        let gridItem = GridItem(.flexible(), spacing: Constants.cardSpacing)

        var count: Int {
            if verticalSizeClass == .compact {
                Constants.tripViewColumnCountCompactLandscape
            } else if horizontalSizeClass == .compact {
                Constants.tripViewColumnCountCompact
            } else  {
                Constants.tripViewColumnCount
            }
        }
        return [GridItem](repeating: gridItem, count: count)
    }

    var body: some View {

        NavigationStack(path: $navigationController.navigationPath) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Constants.cardSpacing) {
                    ForEach(trips) { trip in
                        NavigationLink(value: trip) {
                            TripCard(trip: trip)
                        }
                        .buttonStyle(.plain)
                        .matchedTransitionSource(id: trip.id, in: tripList)
                    }
                }
                .padding(Constants.outerPadding)
            }
            .background(.background.secondary)
            .navigationTitle("Trips")
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip, tripList: tripList)
            }
#if DEBUG
            .toolbar {SamplesToolbarContent()}
#endif
        }
#if os(macOS)
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
//        .containerBackground(Color.red, for: .window)
#else
//        .containerBackground(Color.red, for: .navigation)
#endif
    }
}


#Preview(traits: .previewData, .previewNavigation) {
    TripView()
}


