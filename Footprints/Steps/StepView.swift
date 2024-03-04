//
//  StepView.swift
//  Journal
//
//  Created by Jill Allan on 22/10/2023.
//

import SwiftData
import SwiftUI

struct StepView: View {
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @Query var steps: [Step]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(steps) { step in
                    NavigationLink(value: step) {
                        StepViewRow(step: step)
                    }
                }
            }
            .navigationTitle("Steps")
            .navigationDestination(for: Step.self) { step in
                StepDetailView(step: step)
            }
            
            // MARK: - Debug
            .toolbar {
                #if DEBUG
                ToolbarItem {
                    Button("Samples") {
                        Task {
                            await createData()
                        }
                    }
                }
                #endif
            }
        }
    }
#if DEBUG
    func createData() async {
        await SampleDataGenerator.generateSampleData(modelContext: modelContext)
    }
#endif
}

#Preview {
    StepView()
        .modelContainer(SampleContainer.sample())
}
