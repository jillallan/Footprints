//
//  MapToggle.swift
//  Footprints
//
//  Created by Jill Allan on 20/11/2024.
//

import SwiftUI

struct MapToggle: View {
    @Binding var isMapTappable: Bool
    
    var body: some View {
        VStack {
            Toggle("", systemImage: "plus", isOn: $isMapTappable)
                .toggleStyle(.button)
                .labelStyle(.iconOnly)
                .accentColor(.blue)
                .padding(5)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}

#Preview {
    @Previewable @State var isOn: Bool = false
    
    MapToggle(isMapTappable: $isOn)
}
