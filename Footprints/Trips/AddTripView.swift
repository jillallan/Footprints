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
    @Bindable var trip: Trip
    @State private var isAutoTrackingToggleDisabled: Bool = false
    
    
    // MARK: - Navigation Properties
    @Environment(\.dismiss) private var dismiss
    
    
    @Environment(LocationHandler.self) private var locationHandler
    
    // MARK: - Computed Properties
    var saveDisabled: Bool {
        if trip.title == "" {
            true
        } else {
            false
        }
    }
    
    // MARK: - View
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $trip.title, prompt: Text("Title"), axis: .vertical)
            }
            
            if sizeCategory.isAccessibilityCategory {
                Section("Start Date") {
                    DatePicker("", selection: $trip.startDate, displayedComponents: .date)
                }
                
                Section("End Date") {
                    DatePicker("", selection: $trip.endDate, displayedComponents: .date)
                }
                
                Section("Enable automatic trip tracking") {
                    Toggle("", isOn: $trip.isAutoTrackingOn)
                    //                    } footer: {
                    //                        if locationHandler.locationUpdatesAuthorized == 1 {
                    //                            Text("Auto tracking is disabled as location services have been turned off for this app.  Go to iPhone settings to enable")
                    //                        }
                }
                
            } else {
                Section {
                    DatePicker("Start Date", selection: $trip.startDate, displayedComponents: [.date])
                    DatePicker("End Date", selection: $trip.endDate, displayedComponents: [.date])
                    Toggle("Enable automatic trip tracking", isOn: $trip.isAutoTrackingOn)
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
                    dismiss()
                }
                .disabled(saveDisabled)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    discardNewTrip()
                    dismiss()
                }
            }
        }
        // MARK: - View updates
        .onChange(of: trip.startDate) {
            if trip.endDate < trip.startDate {
                trip.endDate = trip.startDate
            }
        }
        .onChange(of: trip.endDate) {
            if trip.startDate > trip.endDate {
                trip.startDate = trip.endDate
            }
        }
        
        .onChange(of: trip.isAutoTrackingOn) {
            locationHandler.enableLocationServices()
        }
        .onChange(of: locationHandler.locationUpdatesAuthorized) {
            authorisationDidChange()
        }
    }
    
    // MARK: - Methods
//    func addTrip() {
//        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate, isAutoTrackingOn: isAutoTrackingEnabled)
//        
//        modelContext.insert(newTrip)
//        
//        let dataHandler = DataHandler()
//        if dataHandler.isATripActive(context: modelContext) {
//            locationHandler.startLocationServices()
//        }
//        navigationPath.append(newTrip)
//    }
    
    func discardNewTrip() {
        modelContext.delete(trip)
    }
    
    func authorisationDidChange() {
        switch locationHandler.locationUpdatesAuthorized {
        case 0, 2:
            isAutoTrackingToggleDisabled = false
        case 1:
            isAutoTrackingToggleDisabled = true
//            $trip.isAutoTrackingEnabled = false
            trip.isAutoTrackingOn = false
        default:
            return
        }
    }
}

// MARK: - Previews
#Preview {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        AddTripView(trip: .bedminsterToBeijing)
            .environment(LocationHandler.preview)
    }
}
