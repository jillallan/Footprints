//
//  SearchExample.swift
//  Footprints
//
//  Created by Jill Allan on 14/02/2024.
//

import SwiftUI

struct SearchExample: View {
//    @Environment(MapSearchService.self) private var mapSearchService
    @State var searchQuery: String = ""
    let names: [String] = [
        "Jill",
        "Chris",
        "Evie",
        "Arlo",
        "Jill1",
        "Chris1",
        "Evie1",
        "Arlo1",
        "Jill2",
        "Chris2",
        "Evie2",
        "Arlo2",
        "Jill3",
        "Chris3",
        "Evie3",
        "Arlo3",
        "Jill4",
        "Chris4",
        "Evie4",
        "Arlo4",
    ]
    var body: some View {
        NavigationStack {
            List(names, id: \.self) { name in
                Text(name)
            }
            .searchable(
                text: $searchQuery,
//                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search for a location"
            )
            .navigationTitle("Namee")
        }
    }
}

#Preview {
    SearchExample()
}
