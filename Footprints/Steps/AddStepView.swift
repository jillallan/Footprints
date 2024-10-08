//
//  AddStepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct AddStepView: View {
    @Environment(\.modelContext) var modelContext
    let trip: Trip
    @Bindable var step: Step
    @State var stepIsNotSet: Bool = true
    @State var mapRegion = MapCameraPosition.region(MKCoordinateRegion.defaultRegion())
    @Environment(\.dismiss) private var dismiss
    @State private var date: Date = Date.now
    let locationService = LocationService()
    @State private var loadingState = LoadingState.empty
    @State var placemarkName: String = ""
    
    enum LoadingState {
        case empty, loading, success, failed
    }
    
    var body: some View {
        MapReader { mapProxy in
            Map(initialPosition: mapRegion) {
                if step.hasChanges {
                    Annotation("", coordinate: step.coordinate) {
                        DefaultStepMapAnnotation()
                    }
                }
            }
            .onTapGesture { value in
                if let coordinate = mapProxy.convert(value, from: .local) {
                    print("tapped at: \(coordinate)")
                    step.latitude = coordinate.latitude
                    step.longitude = coordinate.longitude
                    step.timestamp = date
                    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    Task {
                        await fetchPlacemark(for: location)
                    }
                    loadingState = .loading
                    
                    stepIsNotSet = false
                }
            }
            .safeAreaInset(edge: .bottom) {
                Form {
                    switch loadingState {
                    case .empty:
                        EmptyNameView()
                    case .loading:
                        LoadingView()
                    case .success:
                        SuccessView(placemarkName: placemarkName)
                    case .failed:
                        FailedView()
                    }
                    DatePicker("Step Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
                .frame(height: 400)
            }
            .onChange(of: date) {
                step.timestamp = date
            }
        }
        .navigationTitle("Add step view")
#if !os(macOS)
        .toolbarBackground(.hidden, for: .navigationBar)
        
    
#elseif os(macOS)
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        //        .navigationTransition(.automatic)
#endif
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("back", systemImage: "chevron.left") {
                    print("Step has changes: \(step.hasChanges)")
                    deleteStep()
                    dismiss()
                }
            }
        }
    }
    
    func fetchPlacemark(for location: CLLocation) async {
        do {
            if let tempPlacemark = try await locationService.fetchPlacemark(for: location) {
                let title  = "\(tempPlacemark.name ?? "No name"), \(tempPlacemark.locality ?? "No Locality")"
                placemarkName = title
                
                loadingState = .success
            } else {
                loadingState = .failed
            }
            
            
        } catch {
            print("Error fetching placemark: \(error)")
            loadingState = .failed
        }
    }
    
    func deleteStep() {
        print(stepIsNotSet)
        if stepIsNotSet {
            if let stepIndex = trip.steps.firstIndex(of: step) {
                trip.steps.remove(at: stepIndex)
            }
            modelContext.delete(step)
        }
    }
}

#Preview(traits: .previewData) {
    NavigationStack {
        AddStepView(trip: .bedminsterToBeijing, step: .atomium)
    }
    
}
