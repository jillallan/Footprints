//
//  ActivityView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import SwiftUI

struct ActivityScrollView: View {
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
                        .background(.regularMaterial)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .aspectRatio(1.5, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
                        .containerRelativeFrame([.horizontal], count: 1, spacing: 0.0)
                        
                        // TODO: Actvities
                    } header: {
                        
                        VStack {
                            Text("Trip Start")
                        }
                        
                        .background(.ultraThickMaterial)
                        
                        
                        // TODO: Trip Overview
                    } footer: {
                        
                        VStack {
                            Text("Trip End")
                        }
                        .background(.regularMaterial)
                    }
                }
                

            }
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            ActivityScrollView(trip: .bedminsterToBeijing)
        }
    }
}
