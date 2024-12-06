//
//  LoadingTextView.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import SwiftUI

struct LoadingView: View {
    let message: String
    
    var body: some View {
        ProgressView() {
            Text(message)
        }
        .progressViewStyle(.circular)
    }
}

#Preview {
    LoadingView(message: "Loading...")
}
