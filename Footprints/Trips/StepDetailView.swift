//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(LocationHandler.self) private var locationHandler
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var step: Step
    @State var isNewStep: Bool = false
    @State private var size: CGSize = .zero
    @State private var isLocationSearchViewPresented: Bool = false
    @State private var stepPosition: MapCameraPosition = .automatic
    @State private var userLocationPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var searchQuery: String = ""
    @State var isSearchPresented: Bool = false
    @State var mapSearchService = MapSearchService()
    @State var dismissSearchView: Bool = false


    
    // FIXME: get region from locale
    @State private var isZoomed = false
    
    var frame: Double {
        isZoomed ? 0.75 : 0.30
    }
    
    var toolbarBackground: Visibility {
        isZoomed ? .visible : .hidden
    }
    
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
                .frame(height: size.height * frame)
                .onTapGesture {
                    withAnimation {
                        isZoomed.toggle()
                    }
//                    isLocationSearchViewPresented.toggle()
                    isSearchPresented.toggle()
                    // TODO: When false make isHittable = false
                }
        
                VStack(alignment: .leading) {
                    Button(editorTitle) {
                        isLocationSearchViewPresented.toggle()
                    }
                    .buttonStyle(.plain)
                    .font(.title)
                    
                    DatePicker("Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])

                    LocationSearchView2(step: step)
                    PhotoGrid()
                }
                .padding()
            }
        }
        
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(toolbarBackground, for: .navigationBar)
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
        
//        .inspector(isPresented: $isLocationSearchViewPresented) {
//            LocationSearchView(step: step)
//        }
        



        .sheet(isPresented: $isLocationSearchViewPresented) {
            withAnimation {
                isZoomed.toggle()
            }
            
        } content: {
            LocationSearchView(step: step)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
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
