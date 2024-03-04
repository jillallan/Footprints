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
    @State var text: String = ""
    @State var isSearchPresented: Bool = false
    let coordinate = CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570)
    
    var body: some View {
        SearchMap()
    }
}

#Preview {
    SettingsView()

    
}
