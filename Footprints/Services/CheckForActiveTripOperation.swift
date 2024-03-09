//
//  CheckForActiveTripOperation.swift
//  Footprints
//
//  Created by Jill Allan on 04/03/2024.
//

import Foundation
import SwiftData

class CheckForActiveTripOperation: Operation {
    private let context: ModelContext
    private let locationHandler: LocationHandler
    
    init(context: ModelContext, locationHandler: LocationHandler) {
        self.context = context
        self.locationHandler = locationHandler
    }
    
    @MainActor
    override func main() {
        let dataHandler = DataHandler()
        if dataHandler.isATripActive(context: context) {
            locationHandler.startLocationServices()
        }
    }
}
