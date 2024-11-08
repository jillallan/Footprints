//
//  MapItemSuccessView.swift
//  Footprints
//
//  Created by Jill Allan on 04/11/2024.
//

import MapKit
import SwiftUI

struct MapItemSuccessView: View {
    let mapItem: MKMapItem
    @State private var icon: String = "car"
    @State private var color: Color = .blue
    @State private var category: String = "other"
    
    var body: some View {
        Form {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                Text(category)
            }
        }
        
        .onAppear {
            if let locationCategory = mapItem.pointOfInterestCategory?.convertCategoryToLocationCategory() {
                icon = locationCategory.icon
                color = locationCategory.color
                category = locationCategory.rawValue
            }
        }
    }
}

//#Preview {
//    MapItemSuccessView()
//}
