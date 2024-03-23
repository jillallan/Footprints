//
//  AddTripView2.swift
//  Footprints
//
//  Created by Jill Allan on 22/03/2024.
//

import SwiftUI

struct AddTripView2: View {
    @Environment(\.sizeCategory) private var sizeCategory
    
    // MARK: - Data Properties
    @Environment(LocationHandler.self) private var locationHandler
    @Environment(\.modelContext) private var modelContext
    @State var title: String = ""
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now
    @State var isAutoTrackingEnabled: Bool = false
    
    // MARK: - Navigation Properties
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationController.self) private var navigation
    
    // MARK: - View Properties
    @State private var isAutoTrackingToggleDisabled: Bool = false
    var saveDisabled: Bool {
        if title == "" {
            true
        } else {
            false
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name your trip", text: $title, prompt: Text("Name your trip"))
                        .accessibilityLabel("trip title")
                }
                Section {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                }
                Section {
                    Toggle("Enable automatic trip tracking", isOn: $isAutoTrackingEnabled)
                        .disabled(isAutoTrackingToggleDisabled)
                } footer: {
                    if locationHandler.locationUpdatesAuthorized == 1 {
                        Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
                    }
                }
            }
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTrip()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onChange(of: isAutoTrackingEnabled) {
                locationHandler.enableLocationServices()
            }
        }
    }
    
    func saveTrip() {
        let newTrip = Trip(
            title: title,
            startDate: startDate,
            endDate: endDate,
            isAutoTrackingOn: isAutoTrackingEnabled
        )
        modelContext.insert(newTrip)
        navigation.navigationPath.append(newTrip)
    }
}

#Preview {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        AddTripView2()
            .environment(LocationHandler.preview)
    }
}
