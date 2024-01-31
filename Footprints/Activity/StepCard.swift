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
                        Text(step.placemark?.name ?? "No Name")
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
                if step.placemark != nil {
                    loadingState = .loaded
                }
            }
            .task {
                if step.placemark == nil {
                    await addPlacemark(for: step)
                }
            }
    }
    
    func addPlacemark(for step: Step) async {
        let result = await locationService.fetchPlacemark(for: step)
        
        switch result {
        case .success(let cLPlacemark):
            addPlacemark(cLPlacemark: cLPlacemark, to: step)
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
    
    func addPlacemark(cLPlacemark: CLPlacemark, to step: Step) {
        let placemark = Placemark(cLPlacemark: cLPlacemark)
        step.placemark = placemark
        modelContext.insert(placemark)
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepCard(step: .bedminsterStation, image: Image(.beach), aspectRatio: 1.5)
    }
}
