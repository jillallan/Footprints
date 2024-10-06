//
//  AddSamplesToolbarItems.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import SwiftUI

struct SamplesToolbarContent: ToolbarContent {
    @Environment(\.modelContext) private var modelContext
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("SAMPLES") {
                Task {
                    await createData()
                }
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Clear") {
                deleteData()
            }
        }
    }
    
    @MainActor
    func createData() async {
        deleteData()
        await PreviewDataGenerator.generatePreviewData(modelContext: modelContext)
    }
    
    func deleteData() {
        try? modelContext.delete(model: Trip.self)
    }
}
