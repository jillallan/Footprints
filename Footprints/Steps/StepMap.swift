//
//  StepMap.swift
//  Footprints
//
//  Created by Jill Allan on 07/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct StepMap: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: StepMap.self)
    )
    
    @Bindable var step: Step
    @State var mapCameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        let _ = Self._printChanges()
        let _ = logger.debug("map item: \(String(describing: step.location?.mapItem.debugDescription))")
        
        Map(position: $mapCameraPosition) {
            if let mapItem = step.location?.mapItem {
                Marker(item: mapItem)
            } else {
                Marker("", coordinate: step.coordinate)
            }
        }
        .frame(height: 250)
        .onAppear {
            if let mapItem = step.location?.mapItem {
                mapCameraPosition = .item(mapItem)
            } else {
                mapCameraPosition = .region(step.region)
            }
        }
        .onChange(of: step.location) {
            if let mapItem = step.location?.mapItem {
                mapCameraPosition = .item(mapItem)
            }
        }
    }
}

#Preview {
    StepMap(step: .bedminsterStation)
}
