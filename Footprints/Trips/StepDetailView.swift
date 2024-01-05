//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var step: Step
    @State var isNewStep: Bool = false
    @State var isInspectorPresented: Bool = false
    @State var text: String = ""
    @State private var size: CGSize = .zero
    
    private var editorTitle: String {
        isNewStep ? "Add Step" : "Placemark Name"
    }
    

    
    var mapHeight: CGFloat {
        if prefersTabNavigation {
            if isInspectorPresented {
                return size.height * 0.35
            } else {
                return size.height * 0.2
            }
            
        } else {
            return 200
        }
    }
    
    var body: some View {
        
        VStack {
            ScrollView {
                if prefersTabNavigation {
                    Map(position: .constant(.automatic)) {
                        // TODO: Add current position marker
                    }
                    .frame(height: mapHeight)
                }
                
                VStack(alignment: .leading) {
                    Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .font(.headline)
                    Text("The Beach")
                        .font(.subheadline)
                        .padding(.bottom)
                    
                    PhotoGrid()
                }
                .padding()
            }
        }
        .if(prefersTabNavigation) { view in
            view.ignoresSafeArea(edges: .top)
        }
        .navigationTitle(editorTitle)
        .navigationBarBackButtonHidden()
        
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
#endif
        .toolbar {
            if isNewStep {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") { dismiss() }
                }
            }
            
            ToolbarItem(placement: .navigation) {
                Button {
                    discardNewStep()
                    dismiss()
                } label: {
                    Label(step.trip?.title ?? "Trip", systemImage: "chevron.left")
                    
                }
                .labelStyle(.titleAndIcon)
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isInspectorPresented.toggle()
                } label: {
                    Label("Toggle Inspector", systemImage: "info.circle")
                }
            }
        }
        
        .inspector(isPresented: $isInspectorPresented) {
            StepInspector(step: step)
//                .presentationDetents([.height(size.height)])
                .presentationDetents([.mediumLarge])
        }
        
        .onAppear {
            if modelContext.insertedModelsArray.contains(where: { $0.persistentModelID == step.persistentModelID }) {
                isNewStep = true
                isInspectorPresented = true
            }
        }
        .getSize($size)
    }
    
    
    func discardNewStep() {
        if isNewStep {
            modelContext.delete(step)
        }
    }
}

#Preview("Edit Step") {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            //            StepDetailView(step: Step.bedminsterStation, text: "Hello world")
            StepDetailView(step: Step.bedminsterStation, text: "Bye bye, hello my name is Jill this is a long 2 line sentence")
        }
    }
}

#Preview("New Step") {
    ModelPreview(SampleContainer.sample) {
        let step = Step(timestamp: .now)
        
        NavigationStack {
            StepDetailView(step: step, isNewStep: true, isInspectorPresented: true)
        }
    }
}
