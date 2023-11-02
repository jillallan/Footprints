//
//  ActivityView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import SwiftUI

struct ActivityView: View {
//    @Bindable var trip: Trip
    let trip: Trip
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach([trip]) { trip in
                    Section {
                        ContentUnavailableView(
                            "Add a step",
                            systemImage: "map",
                            description: Text("No step add your first step")
                        )
                        // TODO: Actvities
                    } header: {
                        
                        // TODO: Trip Overview
                    } footer: {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            ActivityView(trip: .bedminsterToBeijing)
        }
    }
}
