//
//  SearchResults.swift
//  Footprints
//
//  Created by Jill Allan on 16/02/2024.
//

import MapKit
import SwiftUI

struct SearchResults: View {
    let searchResults: [MKMapItem]
    
    var body: some View {
        List {
            ForEach(searchResults) { result in
                Text(result.description)
            }
        }
    }
}

#Preview {
    SearchResults(searchResults: [])
}
