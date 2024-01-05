//
//  PlacemarkView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct PlacemarkView: View {
    @Query var steps: [Step]
//    let numbers: [Int] = [1, 2, 3, 4, 5]

    var body: some View {
        NavigationStack {
            Map()
                .dynamicSafeAreaInset(edge: Edge.leading) {
//                .safeAreaInset(edge: .leading) {
                    VStack {
                        ScrollView {
                            LazyVStack {
                                ForEach(steps) { step in

                                    
                                    NavigationLink(value: step) {

                                        StepCard(step: step, image: Image(.beach), aspectRatio: 1.5)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
                                .containerRelativeFrame([.vertical], count: 1, spacing: 0.0)
                            }
                        }
                    }
                }
            
        }
        .navigationTitle("Placemark View")
        .navigationDestination(for: Int.self) { int in
            Text(int, format: .number)
        }
        
    }
}

#Preview {
    PlacemarkView()
        .modelContainer(SampleContainer.sample())
}
