//
//  TripSummaryCard.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

struct TripSummaryCard: View {
    var body: some View {
        VStack {
            Text("Trip Summary")
                .font(.largeTitle)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    }
}

#Preview {
    TripSummaryCard()
}
