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
    @State private var isAutoTrackingEnabled: Bool = false
    @State private var isAutoTrackingToggleDisabled: Bool = false

    
    // MARK: - Navigation Properties
    @Environment(\.dismiss) private var dismiss
    @Binding var navigationPath: NavigationPath
    
    @Environment(LocationHandler.self) private var locationHandler
  
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
                    
                    Section("Enable automatic trip tracking") {
                        Toggle("", isOn: $isAutoTrackingEnabled)
//                    } footer: {
//                        if locationHandler.locationUpdatesAuthorized == 1 {
//                            Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
//                        }
                    }
                    
                } else {
                    Section {
                        DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                        DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                        Toggle("Enable automatic trip tracking", isOn: $isAutoTrackingEnabled)
                            .disabled(isAutoTrackingToggleDisabled)
                    } footer: {
                        if locationHandler.locationUpdatesAuthorized == 1 {
                            Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
                        }
                    }
                }

                // Add picture
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
        
        .onChange(of: isAutoTrackingEnabled) {
            locationHandler.enableLocationServices()
        }
        .onChange(of: locationHandler.locationUpdatesAuthorized) {
            authorisationDidChange()
        }
    }
    
    // MARK: - Methods
    func addTrip() {
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate, isAutoTrackingOn: isAutoTrackingEnabled)
        
        modelContext.insert(newTrip)
        
        let dataHandler = DataHandler()
        if dataHandler.isATripActive(context: modelContext) {
            locationHandler.startLocationServices()
        }
        
        
        navigationPath.append(newTrip)
    }
    
    func authorisationDidChange() {
        switch locationHandler.locationUpdatesAuthorized {
        case 0, 2:
            isAutoTrackingToggleDisabled = false
        case 1:
            isAutoTrackingToggleDisabled = true
            isAutoTrackingEnabled = false
        default:
            return
        }
    }
}

// MARK: - Previews
#Preview {
    AddTripView(navigationPath: .constant(NavigationPath()))
        .environment(LocationHandler.preview)
}
