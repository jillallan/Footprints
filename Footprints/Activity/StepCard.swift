//
//  StepCard.swift
//  Footprints
//
//  Created by Jill Allan on 12/11/2023.
//

import SwiftUI
import CoreLocation

struct StepCard: View {
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.modelContext) private var modelContext
    @State private var loadingState = LoadingState.loading
    @State private var errorMessage = ""
    let step: Step
    let image: Image
    let aspectRatio: CGFloat
    let locationService = MapService()
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fit)

            .overlay {
                VStack {
                    switch loadingState {
                    case .loading:
                        Text("Getting placename")
                    case .loaded:
                        Text(step.location?.name ?? "No Name")
                    case .failed:
                        Text("There was an error getting a placename")
                    }
                    Text(step.timestamp, style: .date)
                    Text(step.timestamp, style: .time)
                }
                .frame(maxWidth: .infinity, maxHeight:  .infinity)
                .foregroundStyle(Color.white)
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
        let result = await locationService.fetchPlacemark(for: step)
        
        switch result {
        case .success(let cLPlacemark):
            addLocation(cLPlacemark: cLPlacemark, to: step)
            loadingState = .loaded
            
        case .failure(let error):
            switch error {
            case .placemarkError:
                errorMessage = "No location information found"
                loadingState = .failed
            default:
                errorMessage = "Error getting location information, check network connection"
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

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepCard(step: .bedminsterStation, image: Image(.beach), aspectRatio: 1.5)
    }
}
