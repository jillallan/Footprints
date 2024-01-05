//
//  SettingsView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftUI

//struct SettingsView: View {
//    var body: some View {
//        Text(2, format: .number)
//    }
//}

extension PresentationDetent {
    static let bar = Self.custom(BarDetent.self)
    static let small = Self.height(100)
    static let mediumLarge = Self.fraction(0.75)
}


private struct BarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(44, context.maxDetentValue * 0.1)
    }
}


struct SettingsView: View {
    @State private var showSettings = false
    @State private var selectedDetent = PresentationDetent.bar


    var body: some View {
        Button("View Settings") {
            showSettings = true
        }
        .sheet(isPresented: $showSettings) {
            Text("Hello World")
                .interactiveDismissDisabled()
                // set to scroll or resize based on condition, i.e. in list view, when small resize but when large scroll
//                .presentationContentInteraction(.resizes)
//                .presentationCompactAdaptation(.)
                .presentationDetents(
                    [.bar, .small, .medium, .large, .mediumLarge],
                    selection: $selectedDetent)
        }
    }
}

#Preview {
    SettingsView()
}
