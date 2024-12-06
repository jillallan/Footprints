//
//  MapItemDetail.swift
//  Footprints
//
//  Created by Jill Allan on 22/11/2024.
//

import MapKit
import SwiftUI

struct MapItemDetail: View {
    @State var loadingState: LoadingState = .loading
    @State private var locationService = LocationService()
    let mapFeature: MapFeature
    @State private var mapItem: MKMapItem?
    @State var errorMessage: String?
    
    var body: some View {
        List {
            switch loadingState {
            case .loading:
                LoadingView(message: "Fetching location address")
            case .failed:
                FailedView(errorMessage: "Error")
            case .success:
                if let mapItem {
                    MapItemSuccess(mapItem: mapItem)
                }
            }
            
            Section {
                Text(Coordinate(from: mapFeature.coordinate).coordinateString)
            } header: {
                Text("Coordiantes")
            }
            
        }
        .navigationTitle("Location")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            Task {
                let result = await fetchMapItem(for: mapFeature)
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
        .onChange(of: mapFeature) {
            Task {
                let result = await fetchMapItem(for: mapFeature)
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
    
    func fetchMapItem(for mapFeature: MapFeature) async -> Result<MKMapItem, Error> {
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

//#Preview {
//    MapItemDetail()
//}
