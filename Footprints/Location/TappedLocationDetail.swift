//
//  LocationDetailSheet2.swift
//  Footprints
//
//  Created by Jill Allan on 22/11/2024.
//

import MapKit
import SwiftUI

struct TappedLocationDetail: View {
    @Environment(\.dismiss) private var dismiss
    @State private var locationService = LocationService()
    let coordinate: Coordinate
    @State var loadingState: LoadingState = .loading
    @Binding var mapItem: MKMapItem?
    @State var errorMessage: String?
    @Binding var isMapItemSelected: Bool
    
    var body: some View {
        List {
            switch loadingState {
            case .loading:
                LoadingView(message: "Fetching location address")
            case .failed:
                FailedView(errorMessage: "Error")
            case .success:
                if let mapItem {
                    PlacemarkSuccess(placemark: mapItem.placemark)
                }
            }
            
            Section {
                Text(coordinate.coordinateString)
            } header: {
                Text("Coordiantes")
            }
            
            if loadingState == .success {
                Button("Select location") {
                    isMapItemSelected = true
                    dismiss()
                }
            }
            
        }
        
        .onAppear {
            Task {
                let result = await fetchPlacemark(for: coordinate)
                switch result {
                case .success(let mapItem):
                    self.mapItem = mapItem
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
                case .success(let mapItem):
                    self.mapItem = mapItem
                    self.loadingState = .success
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = .failed
                }
            }
        }
    }
    
    func fetchPlacemark(for coordinate: Coordinate) async -> Result<MKMapItem, Error> {
        //        var placemark: MKPlacemark? = nil
        do {
            if let placemark = try await locationService.fetchPlacemark(for: coordinate) {
                let mapItem = MKMapItem(placemark: placemark)
                return .success(mapItem)
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
}

#Preview("loading") {
    let coordinate = Coordinate(latitude: 51.5, longitude: -2.45)
    
    NavigationStack {
        TappedLocationDetail(coordinate: coordinate, loadingState: .loading, mapItem: .constant(nil), isMapItemSelected: .constant(false))
    }
}

#Preview("failed") {
    let coordinate = Coordinate(latitude: 51.5, longitude: -2.45)
    
    NavigationStack {
        TappedLocationDetail(coordinate: coordinate, loadingState: .failed, mapItem: .constant(nil), isMapItemSelected: .constant(false))
    }
}

#Preview("success") {
    let coordinate = Coordinate(latitude: 51.5, longitude: -2.45)
    let placemark = MKPlacemark(coordinate: coordinate.clLocationCoordinate2D)
    let mapItem = MKMapItem(placemark: placemark)
    
    NavigationStack {
        TappedLocationDetail(coordinate: coordinate, loadingState: .success, mapItem: .constant(mapItem), isMapItemSelected: .constant(false))
    }
}
