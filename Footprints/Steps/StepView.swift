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
                .onDelete { indexSet in
                    deleteSteps(indexSet)
                }
            }
            .navigationTitle("Steps")
            .navigationDestination(for: Step.self) { step in
                StepDetailView(step: step)
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
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
    
    func deleteSteps(_ indexSet: IndexSet) {
        for index in indexSet {
            let step = steps[index]
            modelContext.delete(step)
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
