//
//  RecentLocationRow.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import SwiftUI
import CoreLocation

struct RecentLocationRow: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.modelContext) private var modelContext
    @State private var loadingState: LoadingState = LoadingState.loading
    @State private var errorMessage = ""
    let locationService = MapService()
    @Bindable var location: Location
    
    var body: some View {
        HStack {
            Image(systemName: "tree") // placeholder
                .foregroundStyle(Color.red)
            VStack(alignment: .leading) {
                Text(location.title)
                    .font(.headline)
                Text(location.subTitle)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

//#Preview {
//    ModelPreview(SampleContainer.sample) {
//        NavigationStack {
//            RecentLocationRow(location: Location.bigBen)
//        }
//        .environment(LocationHandler.preview)
//    }
//}
