//
//  PlacemarkView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct PlacemarkView: View {
    @Query var steps: [Step]
    let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
//    let numbers: [Int] = [1, 2, 3, 4, 5]

    var body: some View {
        
        
        Text("Hello")
        
        
    }
}

#Preview {
//    NavigationStack {
        PlacemarkView()
            .modelContainer(SampleContainer.sample())
//    }
}
