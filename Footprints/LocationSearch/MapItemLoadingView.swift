//
//  MapItemLoadingView.swift
//  Footprints
//
//  Created by Jill Allan on 04/11/2024.
//

import SwiftUI

struct MapItemLoadingView: View {
    
    var body: some View {
        VStack {
            ProgressView() {
                Text("Loading...")
            }
        }
    }
}

#Preview {
    MapItemLoadingView()
}
