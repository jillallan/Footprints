//
//  StepInspector.swift
//  Footprints
//
//  Created by Jill Allan on 05/01/2024.
//

import MapKit
import SwiftUI

struct StepInspector: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Bindable var step: Step
    @State private var isLocationSearchPresented: Bool = false
    @State private var searchDetents = PresentationDetent.large
    
    let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        VStack {
            if !prefersTabNavigation {
                Map()
//                    .frame(height: 200)
            }
            Form {
            
                Section("Date") {
                    DatePicker("", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                        
                }
                
                Button {
                    isLocationSearchPresented.toggle()
                } label: {
                    Label("Location", systemImage: "globe")
                }
            }

            
        }
        .sheet(isPresented: $isLocationSearchPresented) {
            LocationSearch(region: region, step: step, searchDetent: $searchDetents)
                .presentationDetents([.large, .medium, .small], selection: $searchDetents)
        }
//        .navigationTitle("Current location")
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            StepInspector(step: .bedminsterStation)
        }
    }
}
