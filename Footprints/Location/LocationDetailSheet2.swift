//
//  LocationDetailSheet2.swift
//  Footprints
//
//  Created by Jill Allan on 22/11/2024.
//

import MapKit
import SwiftUI

struct LocationDetailSheet2: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var loadingState: LoadingState = .loading
    @State private var locationService = LocationService()
    let coordinate: Coordinate
    @State private var placemark: MKPlacemark?
    @State private var mapItem: MKMapItem?
    @State var errorMessage: String?
    @Binding var location: Location?
    
    var body: some View {
        NavigationStack {
            List {
                switch loadingState {
                case .loading:
                    LoadingView(message: "Fetching location address")
                case .failed:
                    FailedView(errorMessage: "Error")
                case .success:
                    if let placemark {
                        PlacemarkSuccess(placemark: placemark)
                    }
                }
                
                Section {
                    Text(coordinate.coordinateString)
                } header: {
                    Text("Coordiantes")
                }
                
            }
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Use Location") {
                        location = addLocation(for: placemark)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
        .onAppear {
            Task {
                let result = await fetchPlacemark(for: coordinate)
                switch result {
                    case .success(let placemark):
                    self.placemark = placemark
                    self.loadingState = .success
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = .failed
                }
            }
        }
        .onChange(of: coordinate) {
            Task {
                let result = await fetchPlacemark(for: coordinate)
                switch result {
                    case .success(let placemark):
                    self.placemark = placemark
                    self.loadingState = .success
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = .failed
                }
            }
        }
    }
    
    func addLocation(for placemark: MKPlacemark?) -> Location? {
        guard let placemark else { return nil }
        
        let newLocation = Location(placemark: placemark)
        modelContext.insert(newLocation)
        
        return newLocation
    }
    
    func fetchPlacemark(for coordinate: Coordinate) async -> Result<MKPlacemark, Error> {
//        var placemark: MKPlacemark? = nil
        do {
            if let placemark = try await locationService.fetchPlacemark(for: coordinate) {
                return .success(placemark)
            } else {
                return .failure(Error.self as! Error)
            }
        } catch {
            return .failure(error)
        }
//        } catch CLError.network {
//            errorMessage = "Location details can't be show as the device is not connected to the internet"
//        } catch CLError.geocodeCanceled {
//            errorMessage = "Request was cancelled, retry later"
//        } catch CLError.geocodeFoundNoResult {
//            errorMessage = "No details for this location"
//        } catch CLError.geocodeFoundPartialResult {
//            errorMessage = "No details for this location"
//        } catch {
//            return .failure(error)
//            errorMessage = "Unable to find location"
//        }
    }
    
    func fetchPlacemark(for mapFeature: MapFeature) async -> Result<MKMapItem, Error> {
        do {
            if let mapItem = try await locationService.fetchMapItem(for: mapFeature) {
                return .success(mapItem)
            } else {
                return .failure(Error.self as! Error)
            }
        } catch {
            return .failure(error)
        }
    }
}

#Preview("loading") {
    let coordinate = Coordinate(latitude: 51.5, longitude: -2.45)
    NavigationStack {
        LocationDetailSheet2(loadingState: .loading, coordinate: coordinate, location: .constant(nil))
    }
}

#Preview("failed") {
    let coordinate = Coordinate(latitude: 51.5, longitude: -2.45)
    NavigationStack {
        LocationDetailSheet2(loadingState: .failed, coordinate: coordinate, location: .constant(nil))
    }
}

#Preview("success") {
    let coordinate = Coordinate(latitude: 51.5, longitude: -2.45)
    NavigationStack {
        LocationDetailSheet2(loadingState: .success, coordinate: coordinate, location: .constant(nil))
    }
}
