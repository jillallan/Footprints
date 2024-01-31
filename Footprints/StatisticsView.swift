//
//  StatisticsView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftUI

struct StatisticsView: View {
    @State var isSearchViewPresented: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Button("Search") {
                    isSearchViewPresented.toggle()
                }
            }
            .sheet(isPresented: $isSearchViewPresented) {
//                SearchView()
            }
        }
    }
}

#Preview {
    StatisticsView()
}
