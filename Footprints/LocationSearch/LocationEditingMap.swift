//
//  StrepEditMap.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct LocationEditingMap: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationEditingMap.self)
    )
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var step: Step
    @State var mapRegion: MapCameraPosition
    @Binding var mapItem: MKMapItem
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    let dismiss: DismissAction
    @Binding var selectedLocationSuggestion: LocationSuggestion?
    @State private var locationService = LocationService()
    @State private var mapSelection: MapSelection<MKMapItem>?
    @State private var isLocationSuggestionViewPresented: Bool = false
    @State private var isMapFeatureViewPresented: Bool = false
    
    
    var body: some View {
        let _ = Self._printChanges()
        let _ = logger.info("mapItem map view: \(mapItem.debugDescription)")
        
        Map(initialPosition: mapRegion, selection: $mapSelection) {
            Marker(item: mapItem)
                .tag(MapSelection(mapItem))
        }
        .safeAreaInset(edge: .bottom) {
            if mapSelection != nil {
                Color(.clear)
                    .frame(height: 300)
            }
        }
//        .sheet(isPresented: $isMapFeatureViewPresented, onDismiss: {
//            // TODO: -
//        }, content: {
//            MapItemDetail(mapSelection: mapSelection) { selectedMapItem in
//                if let selectedMapItem {
//                    mapItem = selectedMapItem
//                    let newLocation = Location(coordinate: mapItem.placemark.coordinate, mapItem: mapItem, resultType: .pointOfInterest)
//                    modelContext.insert(newLocation)
////                    step.location = newLocation
//                    newLocation.steps.append(step)
//                    print("step location: \(step.location?.name ?? "none")")
//             
//                    dismiss()
//                }
//            }
//            .mapDetailPresentationStyle()
//        })
        .onChange(of: mapSelection) {
            isMapFeatureViewPresented = true
        }
//        .onChange(of: selectedLocationSuggestion) {
//            isMapFeatureViewPresented = true
//            dismissSearch()
//        }
        .onChange(of: mapItem) {
            mapRegion = MapCameraPosition.item(mapItem)
        }
    }
}

//#Preview {
//    let mapCameraRegion = MapCameraPosition.region(Step.bedminsterStation.region)
//    let mapItemClosure: (MKMapItem) -> Void = { _ in }
//    let locationSuggestion = LocationSuggestion(title: "Bristol", subtitle: "England")
//    LocationEditingMap(
//        mapRegion: mapCameraRegion,
//        selectedLocationSuggestion: .constant(locationSuggestion),
//        mapItemClosure: mapItemClosure
//    )
//}


extension MapFeature: @retroactive Identifiable {
    public var id: UUID {
        UUID()
    }
}

extension MapSelection: @retroactive Identifiable {
    public var id: UUID {
        UUID()
    }
}
