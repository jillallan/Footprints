//
//  TestView.swift
//  Footprints
//
//  Created by Jill Allan on 14/11/2023.
//

import MapKit
import SwiftUI

struct TestView: View {
    var body: some View {
        DynamicSafeAreaInsetOld {
            Map()
        } safeAreaContent: {
            Text("Hello")
        }
            
    }
}

#Preview {
    TestView()
}
