//
//  ActivityScroll.swift
//  Footprints
//
//  Created by Jill Allan on 15/12/2023.
//

import MapKit
import OSLog
import SwiftData
import SwiftUI

struct ActivityScroll: View {
    // MARK: - Debugging
    private let logger = Logger(category: String(describing: ActivityScroll.self))
    
    // MARK: - Data Properties
    @Bindable var trip: Trip
    let steps: [Step]
    
    // MARK: - View Properties
    @Binding var aspectRatio: AspectRatio
    @State private var size: CGSize = .zero
    @Binding var scrollPositionID: PersistentIdentifier?
    
    var body: some View {
        VStack {
            ScrollView(scrollAxis) {
                LazyStack(axes: scrollAxis) {
                    ForEach([trip]) { trip in
                        Section {
                            ForEach(steps) { step in
                                NavigationLink(value: step) {
                                    StepCard(step: step, image: Image(.beach), aspectRatio: cardAspectRatio)
                                }
                                .buttonStyle(.plain)
                            }
                        } header: {
                            TripSummaryCard(trip: trip, stepCount: trip.tripSteps.count)
                        } footer: {
                            TripStatisticsCard()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
                    .containerRelativeFrame([scrollAxis], count: scrollItemCount, spacing: 0.0)
                }
            }
            .scrollPosition(id: $scrollPositionID)
            .scrollTargetBehavior(.paging)
        }
        .navigationDestination(for: Step.self) { step in
            StepDetailView(step: step)
        }
        .if(scrollAxis == .vertical) { view in
            view.frame(width: verticalScrollWidth)
        }
        .if(scrollAxis == .horizontal) { view in
            view.frame(height: horizontalScrollHeight)
        }
        .getSize($size)
    }
    
    var scrollAxis: Axis.Set {
        switch aspectRatio {
        case .landscape(_), .wide(_): Axis.Set.vertical
        case .square(_), .portrait(_), .tall(_), .zero(_): Axis.Set.horizontal
        }
    }
    
    var cardAspectRatio: Double {
        switch aspectRatio {
        case .wide(_): 1.0
        case .landscape(_), .square(_), .portrait(_), .tall(_), .zero(_): 1.5
        }
    }
    
    var scrollItemCount: Int {
        switch aspectRatio {
        case .wide(_), .tall(_): 1
        case .landscape(_), .square(_), .portrait(_), .zero(_): 2
        }
    }
    
    var horizontalScrollHeight: Double {
        // Round height up, otherwise in some cases the scroll view is bigger than the scroll heigth calculated here
        ceil(size.width / (cardAspectRatio * Double(scrollItemCount)))
    }
    
    var verticalScrollWidth: Double {
        // Round width up, otherwise in some cases the scroll view is bigger than the scroll width calculated here
        ceil(size.height * (cardAspectRatio / Double(scrollItemCount)))
    }
}


#Preview("tall") {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        ActivityScroll(
            trip: .bedminsterToBeijing,
            steps: Trip.bedminsterToBeijing.tripSteps,
            aspectRatio: .constant(AspectRatio.tall(aspectRatio: 0.5)),
            scrollPositionID: .constant(Step.bedminsterStation.persistentModelID)
        )
    }
}

#Preview("landscape", traits: .landscapeLeft) {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        Map()
            .dynamicSafeAreaInset(edge: Edge.leading) {
                ActivityScroll(
                    trip: .bedminsterToBeijing,
                    steps: Trip.bedminsterToBeijing.tripSteps,
                    aspectRatio: .constant(AspectRatio.tall(aspectRatio: 1.9)),
                    scrollPositionID: .constant(Step.bedminsterStation.persistentModelID)
                )
            }
        
    }
}
