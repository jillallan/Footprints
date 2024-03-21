//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import MapKit
import OSLog
import SwiftUI

struct StepDetailView: View {
    // MARK: - Logging
    private let logger = Logger(category: String(describing: LocationHandler.self))
    
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @Bindable var step: Step
    @State var isNewStep: Bool = false
    
    // MARK: - View Properties
    @State private var size: CGSize = .zero
    @State private var isZoomed = false
    @State private var sheetSize = PresentationDetent.medium
    @State private var mapHeight: Double = 0.3
    // MARK: - Map Properties
    @State private var stepPosition: MapCameraPosition = .automatic
    @State private var userLocationPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    // MARK: - Search Properties
    @State var result: MKMapItem?
    @State var searchResults: [MKMapItem] = []
    
    // MARK: - Navigation Properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLocationSearchViewPresented: Bool = false
    @State var dismissSearchView: Bool = false
    
    
    // FIXME: get region from locale
    
    // MARK: - Computed Properties
    
    private var editorTitle: String {
        isNewStep ? "Update Location" : step.location?.title ?? "Edit Step"
    }
    
    var body: some View {
        let _ = logger.debug("is zoomed: \(isZoomed)")
        VStack {
            ScrollView {
                StepDetailMap(
                    isNewStep: isNewStep, step: step, searchResults: $searchResults
                )
                .frame(height: size.height * mapHeight)
                .onTapGesture {
                    withAnimation {
//                        isZoomed.toggle()
                        mapHeight = 0.75
                    }
                    
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
                mapHeight = 0.3

            }
            print("result: \(String(describing: result))")
            addLocation(to: step)
        } content: {
            LocationSearchView(
                coordinate: step.coordinate,
                region: MKCoordinateRegion(
                    center: step.coordinate,
                    span: MKCoordinateSpan.example
                ),
                searchResults: $searchResults,
                searchResult: $result

            ) { mapItem in
                result = mapItem
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.small, .medium, .large], selection: $sheetSize)
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
        .onChange(of: sheetSize) {
            withAnimation {
                switch sheetSize {
                case .large:
                    mapHeight = 0.3
                case .medium:
                    mapHeight = 0.75
                case .small:
                    mapHeight = 1.0
                default:
                    mapHeight = 0.3
                }
            }
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
