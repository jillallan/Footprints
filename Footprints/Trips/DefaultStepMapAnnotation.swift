//
//  DefaultStepMapAnnotation.swift
//  Footprints
//
//  Created by Jill Allan on 04/10/2024.
//

import MapKit
import SwiftUI

struct DefaultStepMapAnnotation: View {
    
    var body: some View {
        Image(systemName: "circle")
            .resizable()
            .foregroundStyle(Color.accentColor)
            .frame(width: 15, height: 15)
            .background(Color.white)
            .clipShape(.circle)
    }
}

#Preview {
    DefaultStepMapAnnotation()
}
