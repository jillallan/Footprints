//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var step: Step
    @State var isNewStep: Bool = false
    @State private var size: CGSize = .zero
    @State private var isLocationSearchViewPresented: Bool = false
    @State private var stepPosition: MapCameraPosition = .automatic
    @State private var userLocationPosition: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))
    // FIXME: get region from locale
    
    private var editorTitle: String {
        isNewStep ? "Update Location" : step.location?.title ?? "Edit Step"
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Map(position: isNewStep ? $userLocationPosition : $stepPosition) {
                    Marker("", coordinate: step.coordinate)
                }
                .onAppear {
                    stepPosition = .item(step.mapItem)
                }
                .frame(height: size.height * 0.3)
                
                VStack(alignment: .leading) {
                    Button {
                        isLocationSearchViewPresented.toggle()
                    } label: {
                        Text(editorTitle)
                            .font(.title)
                    }
                    .buttonStyle(.plain)
                    
//                    Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
//                        .font(.subheadline)
                    DatePicker("Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
           
                    
                    PhotoGrid()
                }
                .padding()
            }
        }
        
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
#endif
        .toolbar {
            if isNewStep {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") { dismiss() }
                }
            }
            
            ToolbarItem(placement: .navigation) {
                Button {
                    discardNewStep()
                    dismiss()
                } label: {
                    Label(step.trip?.title ?? "Trip", systemImage: "chevron.left")
                }
                .labelStyle(.titleAndIcon)
            }
        }
        
        .onAppear {
            if modelContext.insertedModelsArray.contains(where: { $0.persistentModelID == step.persistentModelID }) {
                
                print("is step new: \(true)")
                isNewStep = true
            }
        }
        .sheet(isPresented: $isLocationSearchViewPresented) {
            LocationSearchView(step: step)
                .presentationDragIndicator(.visible)
        }
        .onChange(of: step) {
            print("step changed")
            isNewStep = false
        }
        
        .getSize($size)
    }
    
    
    func discardNewStep() {
        if isNewStep {
            modelContext.delete(step)
        }
    }
//    
//    func getLocationFromLocale() -> CLLocation {
//        let locationService = LocationService()
//        guard let region = Locale.current.region?.debugDescription else { return "US" }
//        let result = await locationService.fetchLocation(for: region)
//        
//        switch result {
//        case .success(let cLLocation):
//            return cLLocation
//            
//        case .failure(let error):
//            return
//        }
//    }
}

#Preview("Edit Step") {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            StepDetailView(step: Step.bedminsterStation)
        }
    }
}

#Preview("New Step") {
    ModelPreview(SampleContainer.sample) {
        let step = Step(timestamp: .now, latitude: 0.0, longitude: 0.0)
        
        NavigationStack {
            StepDetailView(step: step, isNewStep: true)
        }
    }
}
