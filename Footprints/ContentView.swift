//
//  ContentView.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @State private var selection: AppScreen? = .trips
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                // FIXME: Widen column width to improve display in large dynamic sizes if navigationSplitViewColumnWidth starts supporting larger widths on iPad
                AppSidebarList(selection: $selection)
                    .navigationSplitViewColumnWidth(min: 100, ideal: 200, max: 300)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleContainer.sample())
        .environment(LocationHandler.preview)
//        .environment(MapSearchService.preview)
}
