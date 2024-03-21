//
//  LocationSearchResults.swift
//  Footprints
//
//  Created by Jill Allan on 16/03/2024.
//

import MapKit
import SwiftUI

struct LocationSearchResults: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var searchResults: [MKMapItem]
    @State var resultClosure: (MKMapItem) -> ()

    
    var body: some View {
        List {
            ForEach(searchResults) { result in
                LocationSearchResultRow(mapItem: result) { mapItem in
                    resultClosure(mapItem)
                    searchResults = []
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    LocationSearchResult(searchResults: .constant([]))
//}
