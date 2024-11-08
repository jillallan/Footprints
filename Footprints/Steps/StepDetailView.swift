//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var step: Step
    @State private var isEditLocationViewPresented: Bool = false
    
    var body: some View {
        ScrollView {
            DatePicker("Step Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                .padding()
            LazyVStack {
                Button {
                    isEditLocationViewPresented.toggle()
                } label: {
                    StepMap(step: step)
                }
                .buttonStyle(.plain)
                ForEach(0..<3) { int in
                    Image(.EBC_1)
                        .resizable()
                        .scaledToFit()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .padding()
            
        }
        .navigationTitle(step.stepTitle)
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(isPresented: $isEditLocationViewPresented) {
            // TODO: -
        } content: {
            if let location = step.location {
                EditLocationView(location: location) { locationID in
                    if let location = modelContext.model(for: locationID) as? Location {
                        step.location = location
                    }
                }
            }
        }
    }
    
    func fetchMapItem(for identifier: String) async -> MKMapItem? {
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await locationService.fetchMapItem(for: identifier)
        } catch {
            
        }
        return mapItem
    }
}

#Preview(traits: .previewData) {
    
    NavigationStack {
        StepDetailView(
            step: .stJohnsLane
        )
    }
}
