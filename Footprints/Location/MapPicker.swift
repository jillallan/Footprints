//
//  MapPicker.swift
//  Footprints
//
//  Created by Jill Allan on 08/12/2024.
//

import SwiftUI

struct MapPicker: View {
    
    @Binding var selectedMap: MapType
    
    var body: some View {
        Picker("Map Type", selection: $selectedMap) {
            Text("Map Features").tag(MapType.mapFeatures)
            Text("Any Location").tag(MapType.anyLocation)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

#Preview {
    MapPicker(selectedMap: .constant(MapType.mapFeatures))
}
