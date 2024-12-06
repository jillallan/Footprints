//
//  FailedView.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import SwiftUI

struct FailedView: View {
    let errorMessage: String
    
    var body: some View {
        Text(errorMessage)
    }
}

#Preview {
    FailedView(errorMessage: "Failed")
}
