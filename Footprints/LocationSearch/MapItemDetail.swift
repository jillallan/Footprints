//
//  MapItemDetail.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct MapItemDetail: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MapItemDetail.self)
    )
    
    @Environment(\.dismiss) var dismiss
    @State private var loadingState = LoadingState.loading
    @State private var locationService = LocationService()
    @State var mapItem: MKMapItem?
    let mapSelection: MapSelection<MKMapItem>?
    let location: Location
    
    var title: String {
        if let mapFeatureTitle = mapSelection?.feature?.title {
            return mapFeatureTitle
        } else if let mapItemName = mapSelection?.value?.name {
            return mapItemName
        } else {
            return "No name found"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch loadingState {
                case .loading: MapItemLoadingView()
                case .success: if let mapItem { MapItemSuccessView(mapItem: mapItem) }
                case .failed: MapItemFailedView()
                }
            }
            .navigationTitle(title)
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Select") {
//                        mapItemClosure(mapItem)
//                        dismiss()
//                    }
//                    .disabled(mapItem == nil)
//                }
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        mapItemClosure(nil)
//                        dismiss()
//                    }
//                    .disabled(mapItem == nil)
//                }
//            }
            .onAppear {
                Task {
                    if let mapFeature = mapSelection?.feature {
                        mapItem = await fetchMapItem(for: mapFeature)
                    }
                    if let selectedMapItem = mapSelection?.value {
                        mapItem = assignMapItem(for: selectedMapItem)
                    }
                }
            }
            .onChange(of: mapSelection) {
                loadingState = .loading
                Task {
                    if let mapFeature = mapSelection?.feature {
                        mapItem = await fetchMapItem(for: mapFeature)
                    } else if let selectedMapItem = mapSelection?.value {
                        mapItem = assignMapItem(for: selectedMapItem)
                    } else {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func fetchMapItem(for searchSuggestion: String) async -> MKMapItem? {
        var mapItem: MKMapItem? = nil
        do {
            if let fetchedMapItem = try await locationService.fetchMapItems(for: searchSuggestion).first {
                mapItem = fetchedMapItem
                loadingState = .success
            } else {
                loadingState = .failed
            }
        } catch {
            loadingState = .failed
        }
        return mapItem
    }
    
    func fetchMapItem(for mapFeature: MapFeature) async -> MKMapItem? {
        let request = MKMapItemRequest(feature: mapFeature)
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await request.mapItem
            loadingState = .success
        } catch let error {
            logger.error("Getting map item from identifier failed. Error: \(error.localizedDescription)")
            loadingState = .failed
        }
        return mapItem
    }
    
    func assignMapItem(for mapItem: MKMapItem) -> MKMapItem {
        loadingState = .success
        return mapItem
    }
}

//#Preview {
//    MapItemDetail()
//}
