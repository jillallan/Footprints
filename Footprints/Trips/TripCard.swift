//
//  TripCardView.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import SwiftUI

struct TripCard: View {
    @Bindable var trip: Trip

    var body: some View {
        VStack {
//            Image(PreviewDataGenerator.randomTripImage)
            Image("EBC1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
                .aspectRatio(1.0, contentMode: .fill)
            VStack {
                Text(trip.title)
                    .font(.headline)
                Text(trip.startDate, style: .date)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.top, 15)
        }
        .padding(.all, 20)
        .background(.background.secondary)
        .cornerRadius(20)
    }
}

#Preview {
    TripCard(trip: .anglesey)
}
