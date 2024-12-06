//
//  AddStepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/12/2024.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

struct AddStepView: View {
    @Environment(\.modelContext) var modelContext

    var body: some View {
        LocationDetailView(currentLocation: CLLocationCoordinate2D.defaultCoordinate()) { mapItem in
            // TODO: -
        }
    }
    
    func addStep(mapItem: MKMapItem) {
        let newLocation = Location(mapItem: mapItem)
        modelContext.insert(newLocation)
        
//        let newStep = Step
    }
}

#Preview {
    AddStepView()
}
