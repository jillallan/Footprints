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
    @Binding var aspectRatio: AspectRatio
    @State private var width: CGFloat = .zero
    @State private var height: CGFloat = .zero

    var cardAspectRatio: Double {
        switch aspectRatio {
        case .wide(_):
            return 1.0
        case .landscape(_), .square(_), .portrait(_), .tall(_), .zero(_):
            return 1.5
        }
    }
    
    var scrollAxis: Axis.Set {
        switch aspectRatio {
        case .wide(_), .landscape(_):
            return .vertical
        case .square(_), .portrait(_), .tall(_), .zero(_):
            return .horizontal
        }
    }
    
    var scrollItemCount: Int {
        switch aspectRatio {
        case .wide(_):
            return 1
        case .landscape(_):
            return 2
        case .square(_):
            return 2
        case .portrait(_):
            return 2
        case .tall(_):
            return 1
        case .zero(_):
            return 2
        }
    }
    
    var horizontalScrollHeight: Double {
        // Round height up, otherwise in some cases the scroll view is bigger than the scroll heigth calculated here
        ceil(width / (cardAspectRatio * Double(scrollItemCount)))
    }
    
    var verticalScrollWidth: Double {
        // Round width up, otherwise in some cases the scroll view is bigger than the scroll width calculated here
        ceil(height * (cardAspectRatio / Double(scrollItemCount)))
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
                                StepCard(image: Image(.beach))
                            }
                        }
                    } header: {
                        TripSummaryCard()
                    } footer: {
                        TripStatisticsCard()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
                .containerRelativeFrame([scrollAxis], count: scrollItemCount, spacing: 0.0)
                .scrollTransition(axis: .horizontal) { content, phase in
                    content
                        .scaleEffect(phase.isIdentity ? 1 : 0.90)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        
        .getWidth($width)
        .getHeight($height)
        .if(scrollAxis == .vertical) { view in
            view
                .frame(width: verticalScrollWidth)
        }
        .if(scrollAxis == .horizontal) { view in
            view
                .frame(height: horizontalScrollHeight)
        }
    }
}

#Preview("Trip with steps aspect ratio 0.5") {
    ModelPreview(SampleContainer.sample) {
        GeometryReader { geometry in
            NavigationStack {
                ActivityScroll(
                    trip: .bedminsterToBeijing, 
                    navigationPath: .constant(NavigationPath()),
                    aspectRatio: .constant(.tall(aspectRatio: 0.5))
                )
            }
        }
    }
}

#Preview("Trip with steps landscape") {
    ModelPreview(SampleContainer.sample) {
        GeometryReader { geometry in
            NavigationStack {
                ActivityScroll(
                    trip: .bedminsterToBeijing,
                    navigationPath: .constant(NavigationPath()),
                    aspectRatio: .constant(.landscape(aspectRatio: 2.0 / 3.0))
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
                    navigationPath: .constant(NavigationPath()),
                    aspectRatio: .constant(.tall(aspectRatio: 1.5))
                )
            }
        }
    }
}
