//
//  TripSummaryCard.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2023.
//

import SwiftUI

struct TripSummaryCard: View {
    @State private var height: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    var body: some View {
        let _ = print("card height: \(height)")
        let _ = print("card width: \(width)")
        VStack {
            Text("Trip Summary")
                .font(.largeTitle)
            Spacer()
        }
//        .frame(maxWidth: .infinity)
        .frame(maxWidth: .infinity, maxHeight:  .infinity)
//        .padding()
        .background(.regularMaterial)
        .getWidth($width)
        .getHeight($height)
        .onChange(of: height) {
            print("card height: \(height)")
        }
        .onChange(of: width) {
            print("card width: \(width)")
        }
        .onAppear {
            print("card height: \(height)")
            print("card width: \(width)")
        }
    }
}

#Preview {
    TripSummaryCard()
}
