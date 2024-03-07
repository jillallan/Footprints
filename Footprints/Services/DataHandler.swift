//
//  DataHandler.swift
//  Footprints
//
//  Created by Jill Allan on 05/03/2024.
//

import Foundation
import SwiftData

struct DataHandler {
//    let container: ModelContainer
//    
//    init() {
//        let schema = Schema([Trip.self])
//        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
//        
//        do {
//            container = try ModelContainer(for: schema, configurations: [configuration])
//        } catch {
//            fatalError("Error creating model container: \(error.localizedDescription)")
//        }
//    }
    
    static func checkLocationServicesRequired(context: ModelContext) -> Bool {
        let now = Date.now
        print("now: \(now)")
        let fetchDescriptor = FetchDescriptor<Trip>(
            predicate: #Predicate { $0.startDate <= now && $0.endDate >= now && $0.isAutoTrackingOn == true }
        )
        
        let fetchDescriptor2 = FetchDescriptor<Trip>()
        
        do {
            let liveTripsCount = try context.fetchCount(fetchDescriptor)
            if liveTripsCount == 0 {
                return false
            } else {
                return true
            }
        } catch {
            // TODO: Add alert to user
            return false
        }
    }
    
    static func fetchCurrentTrip(context: ModelContext) -> Trip? {
        let now = Date.now
        let fetchDescriptor = FetchDescriptor<Trip>(
            predicate: #Predicate { $0.startDate <= now && $0.endDate >= now && $0.isAutoTrackingOn == true }
        )
        
        let fetchDescriptor2 = FetchDescriptor<Trip>()
        
        do {
            let trips = try context.fetch(fetchDescriptor)
            if let trip = trips.first {
                return trip
            } else {
                return nil
            }
            
        } catch {
            // TODO: Add alert to user
            return nil
        }
    }
    
}
