//
//  ModelPreview.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import SwiftUI
import SwiftData

struct ModelPreview<Content: View>: View {
    var content: () -> Content
    var sampleContainer = SampleContainer(inMemory: true)
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .modelContainer(sampleContainer.container)
    }
}
