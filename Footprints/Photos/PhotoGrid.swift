//
//  PhotoGrid.swift
//  Footprints
//
//  Created by Jill Allan on 05/01/2024.
//

import SwiftUI

struct PhotoGrid: View {
    var body: some View {
        LazyVStack {
            ForEach(0..<5) {_ in
                Image(.beach)
                    .resizable()
                    .scaledToFit()
                
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
    }
}

#Preview {
    ScrollView {
        PhotoGrid()
    }
}
