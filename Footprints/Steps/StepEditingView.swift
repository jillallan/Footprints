//
//  StepEditingView.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import MapKit
import SwiftUI

struct StepEditingView: View {
    @Bindable var step: Step
    @State private var mapRegion = MapCameraPosition.automatic
    @State private var isSearchSheetPresented: Bool = false
    
    enum LoadingState {
        case empty, loading, success, failed
    }
    
    var body: some View {
        NavigationStack {
            MapReader { mapProxy in
                Map(position: $mapRegion)
            }
            .navigationTitle("Edit Step")
            .toolbarBackground(.hidden, for: .navigationBar)
            .sheet(isPresented: .constant(true)) {
                
            } content: {
                
            }

        }
    }
}

#Preview {
    StepEditingView(step: .atomium)
}
