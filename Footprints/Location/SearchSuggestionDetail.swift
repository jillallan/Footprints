//
//  SearchSuggestionDetail.swift
//  Footprints
//
//  Created by Jill Allan on 07/12/2024.
//

import MapKit
import SwiftUI

struct SearchSuggestionDetail: View {
    @Environment(\.dismiss) var dismiss
    @State private var locationService = LocationService()
    @State var loadingState: LoadingState = .loading
    let searchSuggestion: LocationSuggestion
    @Binding var mapItem: MKMapItem?
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
//                Text(Coordinate(from: mapFeature.coordinate).coordinateString)
            } header: {
                Text("Coordiantes")
            }
            
            if loadingState == .success {
                Button("Select location") {
                    dismiss()
                }
            }
        }
        .onAppear {
            Task {
                let result = await fetchMapItem(for: searchSuggestion)
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
        .onChange(of: searchSuggestion) {
            Task {
                let result = await fetchMapItem(for: searchSuggestion)
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
    func fetchMapItem(for locationSuggestion: LocationSuggestion?) async -> Result<MKMapItem, Error> {
        guard let searchQuery = locationSuggestion?.mapItemSearchTerm else {
            return .failure(Error.self as! Error)
        }
        do {
            if let mapItem = try await locationService.fetchMapItems(for: searchQuery).first {
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
//    SearchSuggestionDetail()
//}
