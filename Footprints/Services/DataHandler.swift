//
//  DataHandler.swift
//  Footprints
//
//  Created by Jill Allan on 05/03/2024.
//

import Foundation
import OSLog
import SwiftData

struct DataHandler {
    
    private let logger = Logger(category: String(describing: DataHandler.self))
    
    func getActiveTripDescriptor() -> FetchDescriptor<Trip> {
        let now = Date.now
        
        let tripPredicate = #Predicate<Trip> { trip in
            trip.startDate <= now && trip.endDate >= now && trip.isAutoTrackingOn
        }
        
        return FetchDescriptor<Trip>(predicate: tripPredicate)

    }
    
    func isATripActive(context: ModelContext) -> Bool {
        
        let fetchDescriptor = getActiveTripDescriptor()

        do {
            let liveTripsCount = try context.fetchCount(fetchDescriptor)
            if liveTripsCount == 0 {
                logger.debug("\(#function) : \(#line) : \(String(describing: liveTripsCount))")
                return false
            } else {
                return true
            }
        } catch {
            // Alert user that fetch failed - propogate to caller as the impact is not here
            // e.g. starting location services
            return false
        }
    }
    
    func fetchActiveTrip(context: ModelContext) -> Trip? {
        
        let fetchDescriptor = getActiveTripDescriptor()
        
        do {
            let trips = try context.fetch(fetchDescriptor)
            if let trip = trips.first {
                logger.debug("\(#function) : \(#line) : \(trip.debugDescription)")
                return trip
            } else {
                return nil
            }
            
        } catch {
            // Alert user that fetch failed - propogate to caller as the impact is not here
            // e.g. starting location services
            return nil
        }
    }
    
}
