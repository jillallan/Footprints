//
//  EditStepForm.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct EmptyNameView: View {
    var body: some View {
        Text("New Step")
    }
}
    
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    let placemarkName: String
    
    var body: some View {
        Text(placemarkName)
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct EditStepForm: View {
    @State var loadingState: LoadingState
    @State var placemarkName: String
    @State var date: Date
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [MKLocalSearchCompletion] = []
    
    var body: some View {
        NavigationStack {
            Form {
                
                switch loadingState {
                case .empty:
                    EmptyNameView()
                case .loading:
                    LoadingView()
                case .success:
                    SuccessView(placemarkName: placemarkName)
                case .failed:
                    FailedView()
                }
                DatePicker("Step Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
            }
            .searchable(text: $searchQuery)
            .searchSuggestions {
                ForEach(locationSuggestions, id: \.self) { suggestion in
                    VStack(alignment: .leading) {
                        Text(suggestion.title)
                            .font(.headline)
                        Text(suggestion.subtitle)
                            .font(.subheadline)
                    }
                }
            }
            .onChange(of: searchQuery) {
                Task {
                    do {
                        locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery)
                    } catch {
                        
                    }
                }
            }
            
        }
        
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        
    }
    
    func updateSearchResults() async {
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery)
        } catch {
//            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
}
    
#Preview {
    EditStepForm(loadingState: .success, placemarkName: "Placemark name", date: Date.now)
}
