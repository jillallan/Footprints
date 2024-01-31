//
//  SearchResult.swift
//  Footprints
//
//  Created by Jill Allan on 30/01/2024.
//

import SwiftUI
import MapKit

struct LocationSearchResult: View {
    let result: MKMapItem
    
    var body: some View {
        Text(result.name ?? "No name")
    }
}

//#Preview {
//    SearchResult(name: "Jill")
//}
