//
//  AddTripView.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.sizeCategory) private var sizeCategory
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var navigationPath: NavigationPath
  
    @State private var title = ""
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title, prompt: Text("Title"), axis: .vertical)
                }
                
                if sizeCategory.isAccessibilityCategory {
                    Section("Start Date") {
                        DatePicker("", selection: $startDate, displayedComponents: .date)
                    }
                    
                    Section("End Date") {
                        DatePicker("", selection: $endDate, displayedComponents: .date)
                    }
                    
                } else {
                    Section {
                        DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                            
                        DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                            
                    }
                }
                
                // TODO: Add picture
            }
            .formStyle(.grouped)
            .navigationTitle("Add Trip")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addTrip()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
#if !os(iOS)
            .frame(minWidth: 440, maxWidth: .infinity, minHeight: 220, maxHeight: .infinity)
#endif
        }
        .onChange(of: startDate) {
            if endDate < startDate {
                endDate = startDate
            }
        }
        .onChange(of: endDate) {
            if startDate > endDate {
                startDate = endDate
            }
        }
    }
    
    func addTrip() {
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate)
        modelContext.insert(newTrip)
        navigationPath.append(newTrip)
    }
}

#Preview {
    AddTripView(navigationPath: .constant(NavigationPath()))
}
