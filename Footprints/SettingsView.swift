//
//  SettingsView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

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
    @Query var steps: [Step]

    var body: some View {
        NavigationStack {
            if let step = steps.first {
                VStack {
                    ScrollView {
                        Map()
                        LocationSearchView2(step: step)
                    }
                }
            } else {
                Text("no step")
            }
        }
    }
}

#Preview {
    SettingsView()
}
