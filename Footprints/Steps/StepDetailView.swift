//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var step: Step
    @State var isNewStep: Bool = false
    @State private var size: CGSize = .zero
    @State private var isLocationSearchViewPresented: Bool = false
    @State private var stepPosition: MapCameraPosition = .automatic
    @State private var userLocationPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State var dismissSearchView: Bool = false
    @State var result: MKMapItem?
    @State var searchResults: [MKMapItem] = []
    
    
    // FIXME: get region from locale
    @State private var isZoomed = false
    
    var frame: Double {
        isZoomed ? 0.75 : 0.30
    }
    
    private var editorTitle: String {
        isNewStep ? "Update Location" : step.location?.title ?? "Edit Step"
    }
    
    var body: some View {
        VStack {
            ScrollView {
                StepDetailMap(isNewStep: isNewStep, step: step, searchResults: $searchResults)
                .frame(height: size.height * frame)
                .onTapGesture {
                    withAnimation { isZoomed.toggle() }
                    isLocationSearchViewPresented.toggle()
                }
                StepDetailSummary(step: step, editorTitle: editorTitle, isLocationSearchViewPresented: $isLocationSearchViewPresented)
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
        .sheet(isPresented: $isLocationSearchViewPresented) {
            withAnimation {
                isZoomed.toggle()
            }
            print("result: \(String(describing: result))")
            addLocation(to: step)
        } content: {
            LocationSearchView(
                coordinate: step.coordinate,
                region: MKCoordinateRegion(
                    center: step.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)),
                searchResults: $searchResults
            ) { mapItem in
                result = mapItem
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.small, .medium, .large], selection: .constant(.medium))
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .interactiveDismissDisabled()
        }
        .onAppear {
            if modelContext.insertedModelsArray.contains(where: { $0.persistentModelID == step.persistentModelID }) {
                
                print("is step new: \(true)")
                isNewStep = true
            }
        }
        .onChange(of: step) {
            print("step changed")
            isNewStep = false
        }
        .getSize($size)
    }
    
    func addLocation(to step: Step) {
        if let placemark = result?.placemark {
            let newLocation = Location(cLPlacemark: placemark)
            modelContext.insert(newLocation)
            step.location = newLocation
        }
    }
    
    func discardNewStep() {
        if isNewStep {
            modelContext.delete(step)
        }
    }
}

#Preview("Edit Step") {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            StepDetailView(step: Step.bedminsterStation)
        }
        .environment(LocationHandler.preview)
    }
}

#Preview("New Step") {
    ModelPreview(SampleContainer.sample) {
        let step = Step(timestamp: .now, latitude: 0.0, longitude: 0.0)
        
        NavigationStack {
            StepDetailView(step: step, isNewStep: true)
        }
        .environment(LocationHandler.preview)
    }
}
