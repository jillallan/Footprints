//
//  PlacemarkSheet.swift
//  Footprints
//
//  Created by Jill Allan on 15/11/2024.
//

import MapKit
import SwiftUI

struct LocationDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State var loadingState: LoadingState = .loading
    @State private var locationService = LocationService()
    @Binding var coordiante: Coordinate?
    @Binding var mapFeature: MapFeature?
    @State private var placemark: MKPlacemark?
    @State private var mapItem: MKMapItem?
    @State var errorMessage: String = ""
    var placemarkFinal: MKPlacemark? {
        if let mapItemPlacemark = mapItem?.placemark {
            return mapItemPlacemark
        } else {
            return placemark
        }
    }
    
    var body: some View {
        let _ = print("placemark view: \(String(describing: coordiante))")
        let _ = print("placemark view: \(String(describing: mapFeature?.title))")
        NavigationStack {
            VStack {
                switch loadingState {
                case .loading:
                    LoadingView(message: "Fetching location details...")
                case .success:
                    if let placemark {
                        PlacemarkSuccess(placemark: placemark)
                    }
                case .failed:
                    FailedView(errorMessage: errorMessage)
                }
            }
            .toolbar {
                if placemark != nil {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add") {
                            // TODO: -
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // TODO: -
                    }
                }
            }

            .onAppear {
                Task {
                    if let coordiante {
                        placemark = await fetchPlacemark(for: coordiante)
                    }
                    if let mapFeature {
                        mapItem = await fetchPlacemark(for: mapFeature)
                    }
                }
            }
            .onChange(of: coordiante) {
                Task {
                    if let coordiante {
                        placemark = await fetchPlacemark(for: coordiante)
                    }
                }
            }
            .onChange(of: mapFeature) {
                Task {
                    if let mapFeature {
                        mapItem = await fetchPlacemark(for: mapFeature)
                    }
                }
            }
        }
    }
    
    func fetchPlacemark(for coordinate: Coordinate) async -> MKPlacemark? {
        var placemark: MKPlacemark? = nil
        do {
            if let coordiante  {
                placemark = try await locationService.fetchPlacemark(for: coordiante)
            }
            loadingState = .success
        } catch CLError.network {
            errorMessage = "Location details can't be show as the device is not connected to the internet"
            loadingState = .failed
        } catch CLError.geocodeCanceled {
            errorMessage = "Request was cancelled, retry later"
            loadingState = .failed
        } catch CLError.geocodeFoundNoResult {
            errorMessage = "No details for this location"
            loadingState = .failed
        } catch CLError.geocodeFoundPartialResult {
            errorMessage = "No details for this location"
            loadingState = .failed
        } catch {
            errorMessage = "Unable to find location"
        }
        return placemark
    }
    
    func fetchPlacemark(for mapFeature: MapFeature) async -> MKMapItem? {
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await locationService.fetchMapItem(for: mapFeature)
            loadingState = .success
        } catch {
            errorMessage = "Unable to find location"
            loadingState = .failed
        }
        return mapItem
    }
}

#Preview("Success coordinate") {
    NavigationStack {
        LocationDetailSheet(coordiante: .constant(Coordinate(latitude: 51.5567, longitude: 0.1256)), mapFeature: .constant(nil))
    }
}

//#Preview("Success map feature") {
//    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D.defaultCoordinate()))
//    
//    let mapFeature = MapSelection(mapItem)
//    NavigationStack {
//        LocationDetailSheet(coordiante: .constant(nil), mapFeature: .constant(mapFeature))
//    }
//}

#Preview("Loading") {
    @Previewable @State var loadingState: LoadingState = .loading
    NavigationStack {
        LocationDetailSheet(loadingState: loadingState, coordiante: .constant(nil), mapFeature: .constant(nil))
    }
}

#Preview("Failed") {
    @Previewable @State var loadingState: LoadingState = .failed
    @Previewable @State var errorString: String = "Location details can't be show as the device is not connected to the internet"
    
    NavigationStack {
        LocationDetailSheet(loadingState: loadingState, coordiante: .constant(nil), mapFeature: .constant(nil), errorMessage: errorString)
    }
}
