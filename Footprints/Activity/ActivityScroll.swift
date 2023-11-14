//
//  ActivityScroll.swift
//  Footprints
//
//  Created by Jill Allan on 10/11/2023.
//

import SwiftUI

struct ActivityScroll: View {
    let trip: Trip
    @Binding var navigationPath: NavigationPath
    @State var width: CGFloat = .zero
    @State var height: CGFloat = .zero
    
    var scrollAxis: Axis.Set {
        .vertical
    }
    
    var body: some View {

        ScrollView(scrollAxis) {
            LazyStack(axes: scrollAxis) {
                ForEach([trip]) { trip in
                    Section {
                        if trip.tripSteps.isEmpty {
                            AddFirstStepCard()
                        } else {
                            ForEach(trip.tripSteps) { step in
                                StepCard(image: UIImage(resource: .beach))
                            }
                        }
                    } header: {
                        TripSummaryCard()
                    } footer: {
                        TripStatisticsCard()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
                .containerRelativeFrame([scrollAxis], count: 1, spacing: 0.0)
            }
        }
        .getWidth($width)
        .getHeight($height)
        .if(scrollAxis == .vertical) { view in
            view
                .frame(width: height)
        }
        .if(scrollAxis == .horizontal) { view in
            view
                .frame(height: width / 1.5)
        }
//        .frame(height: width / 1.5)
//        .frame(width: height)
    }
}

#Preview("Trip with steps") {
    ModelPreview(SampleContainer.sample) {
        GeometryReader { geometry in
            NavigationStack {
                ActivityScroll(
                    trip: .bedminsterToBeijing, 
                    navigationPath: .constant(NavigationPath())
                )
            }
        }
    }
}

#Preview("Trip with no steps") {
    ModelPreview(SampleContainer.sample) {
        GeometryReader { geometry in
            NavigationStack {
                ActivityScroll(
                    trip: .mountains,
                    navigationPath: .constant(NavigationPath())
                )
            }
        }
    }
}


