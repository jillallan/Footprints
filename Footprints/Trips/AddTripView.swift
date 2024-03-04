//
//  AddTripView.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.sizeCategory) private var sizeCategory
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @State private var title = ""
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    // MARK: - Navigation Properties
    @Environment(\.dismiss) private var dismiss
    @Binding var navigationPath: NavigationPath
  
    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if title == "" {
            true
        } else {
            false
        }
    }
    
    // MARK: - View
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
                        Toggle("Enable automatic trip tracking", isOn: <#T##Binding<Bool>#>)
                    }
                }

                // TODO: Add picture
            }
            .formStyle(.grouped)
            .macOS { $0.frame(minWidth: 440, maxWidth: .infinity, minHeight: 220, maxHeight: .infinity) }
            
            // MARK: - Navigation
            .navigationTitle("Add Trip")
            .iOS { $0.navigationBarTitleDisplayMode(.inline) }
            
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addTrip()
                        dismiss()
                    }
                    .disabled(saveDisabled)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }

        }
        // MARK: - View updates
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
    
    // MARK: - Methods
    func addTrip() {
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate)
        modelContext.insert(newTrip)
        navigationPath.append(newTrip)
    }
}

// MARK: - Previews
#Preview {
    AddTripView(navigationPath: .constant(NavigationPath()))
}
