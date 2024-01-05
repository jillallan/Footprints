//
//  StepScroll.swift
//  Footprints
//
//  Created by Jill Allan on 26/12/2023.
//

import SwiftData
import SwiftUI

struct StepScroll: View {
    @Bindable var step: Step
    @Binding var aspectRatio: AspectRatio
    @State private var size: CGSize = .zero
    @State var scrollPositionID: PersistentIdentifier?
    
    var body: some View {
        VStack {
            ScrollView(scrollAxis) {
                LazyStack(axes: scrollAxis) {
  
                        Section {
                            // TODO: Photo assests
//                            ForEach(steps) { step in
//                                NavigationLink(value: step) {
//                                    StepCard(step: step, image: Image(.beach))
//                                }
//                            }
                        } header: {
                            StepOverviewCard(step: step, image: Image(.beach))
                        } footer: {
                            TripStatisticsCard()
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
        .getSize($size)
        .if(scrollAxis == .vertical) { view in
            view
                .frame(width: verticalScrollWidth)
        }
        .if(scrollAxis == .horizontal) { view in
            view
                .frame(height: horizontalScrollHeight)
        }
    }
    
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
        case .wide(_), .tall(_):
            return 1
        case .landscape(_), .square(_), .portrait(_), .zero(_):
            return 2
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

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepScroll(step: .bedminsterStation, aspectRatio: .constant(.tall(aspectRatio: 2.2)))
 
    }
    
}
