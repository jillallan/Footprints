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
    let container: ModelContainer
    
    init(@ViewBuilder content: @escaping () -> Content, modelContainer: @escaping () throws -> ModelContainer) {
        self.content = content
        do {
            self.container = try MainActor.assumeIsolated(modelContainer)
        } catch {
            fatalError("Failed to create the model container: \(error.localizedDescription)")
        }
    }
    
    init(_ modelContainer: @escaping () throws -> ModelContainer, @ViewBuilder content: @escaping () -> Content) {
        self.init(content: content, modelContainer: modelContainer)
    }

    var body: some View {
        content()
            .modelContainer(container)
    }
}
