//
//  MapItemLoadingView.swift
//  Footprints
//
//  Created by Jill Allan on 04/11/2024.
//

import SwiftUI

struct MapItemLoadingView: View {
    let title: String
    
    var body: some View {
        VStack {
            ProgressView() {
                Text("Loading...")
            }
        }
        .navigationTitle(title)
    }
}

#Preview {
    MapItemLoadingView(title: "The Shop")
}
