//
//  LocationName.swift
//  Footprints
//
//  Created by Jill Allan on 04/03/2024.
//

import CoreLocation
import SwiftUI

struct LocationName: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    // MARK: - Data properties
    @Environment(\.modelContext) private var modelContext
    @Bindable var step: Step
    
    // MARK: - View properties
    @State private var loadingState = LoadingState.loading
    @State private var errorMessage = ""
    let alignment: HorizontalAlignment
    
    var body: some View {
        Group {
            switch loadingState {
            case .loading:
                LocationLoading()
            case .failed:
                LocationError(errorMessage: errorMessage)
            case .loaded:
                LocationLoaded(locationName: step.location?.title ?? "No name", alignment: alignment)
            }
        }
        .onAppear {
            if step.location != nil {
                loadingState = .loaded
            }
        }
        .task {
            if step.location == nil {
                await addLocation(for: step)
            }
        }
    }
    
    func addLocation(for step: Step) async {
        let mapService = MapService()
        let result = await mapService.fetchPlacemark(for: step)
        
        switch result {
        case .success(let cLPlacemark):
            addLocation(cLPlacemark: cLPlacemark, to: step)
            loadingState = .loaded
            
        case .failure(let error):
            switch error {
            case .placemarkError:
                errorMessage = "No location information found"
                loadingState = .failed
            case .geocodeError:
                errorMessage = "Error loading location, check network connection"
                loadingState = .failed
            default:
                errorMessage = "Error loading location"
                loadingState = .failed
            }
        }
    }
    
    func addLocation(cLPlacemark: CLPlacemark, to step: Step) {
        let location = Location(cLPlacemark: cLPlacemark)
        step.location = location
        modelContext.insert(location)
    }
}

#Preview("Default") {
    ModelPreview(SampleContainer.sample) {
        LocationName(step: .bedminsterStation, alignment: .center)
    }
}

#Preview("Loaded") {
    ModelPreview(SampleContainer.sample) {
        let step = Step.bedminsterStation
        List {
            VStack() {
                
                LocationLoaded(locationName: "Bedminster", alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                    HStack {
                        Text("Coordinate: ")
                        Spacer()
                        Text(step.latitude, format: .number)
                        Text(step.longitude, format: .number)
                    }
                    Text("Trip") + Text(step.trip?.title ?? "No trip")
                }
            }
        }
    }
}

#Preview("Loading") {
    ModelPreview(SampleContainer.sample) {
        let step = Step.bedminsterStation
        List {
            VStack() {
                
                LocationLoading()
                
                VStack(alignment: .leading) {
                    Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                    HStack {
                        Text("Coordinate: ")
                        Spacer()
                        Text(step.latitude, format: .number)
                        Text(step.longitude, format: .number)
                    }
                    Text("Trip") + Text(step.trip?.title ?? "No trip")
                }
            }
        }
    }
}

#Preview("Failed") {
    ModelPreview(SampleContainer.sample) {
        let step = Step.bedminsterStation
        List {
            VStack() {
                LocationError(errorMessage: "Error loading location, check network connection")
                
                VStack(alignment: .leading) {
                    Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                    HStack {
                        Text("Coordinate: ")
                        Spacer()
                        Text(step.latitude, format: .number)
                        Text(step.longitude, format: .number)
                    }
                    Text("Trip") + Text(step.trip?.title ?? "No trip")
                }
            }
        }
    }
}

