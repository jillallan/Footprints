//
//  TripSummaryCard.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

struct TripSummaryCard: View {
    @Bindable var trip: Trip
    let stepCount: Int
    
    var body: some View {
        VStack {
            Text("Trip Summary")
                .font(.largeTitle)
            Spacer()
            Text(trip.startDate.formatted(date: .abbreviated, time: .omitted))
            Text(trip.endDate.formatted(date: .numeric, time: .shortened))
            Text(stepCount, format: .number)
        }
        .frame(maxWidth: .infinity, maxHeight:  .infinity)
        .background(.regularMaterial)
    }
}

//#Preview {
//    TripSummaryCard()
//}
