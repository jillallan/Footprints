//
//  TripStatisticsCard.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

struct TripStatisticsCard: View {
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    }
}

#Preview {
    TripStatisticsCard()
}
