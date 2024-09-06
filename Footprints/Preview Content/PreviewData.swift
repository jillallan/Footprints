//
//  SampleData.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import SwiftData
import SwiftUI

struct PreviewData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Trip.self, Step.self,
            configurations: config
        )

        await PreviewDataGenerator.generatePreviewData(modelContext: container.mainContext)
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var previewData: Self = .modifier(PreviewData())
}
