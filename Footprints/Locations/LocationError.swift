//
//  LocationError.swift
//  Footprints
//
//  Created by Jill Allan on 04/03/2024.
//

import SwiftUI

struct LocationError: View {
    let errorMessage: String
    
    var body: some View {
        Text(errorMessage)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.gray)
            .padding()
    }
}
