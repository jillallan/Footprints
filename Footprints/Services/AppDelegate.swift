//
//  AppDelegate.swift
//  Footprints
//
//  Created by Jill Allan on 31/01/2024.
//

#if os(iOS)
import BackgroundTasks
import Foundation
import OSLog
import SwiftData
import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    private let logger = Logger(category: String(describing: AppDelegate.self))
    
    @State var locationHandler: LocationHandler
    let container: ModelContainer

    override init() {
        
        
        let schema = Schema([Trip.self])
#if DEBUG
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
#else
        let configuration = ModelConfiguration()
#endif

        do {
            container = try ModelContainer(for: schema, configurations: [configuration])
            
            let locationHandler = LocationHandler(context: container.mainContext)
            _locationHandler = State(wrappedValue: locationHandler)
        } catch {
            fatalError("Error creating container: \(error.localizedDescription)")
        }
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.footprints.location", using: nil) { (task) in
            self.handleUpdateLocationSettings(task: task as! BGAppRefreshTask)
        }
        
        let dataHandler = DataHandler()
        if dataHandler.isATripActive(context: container.mainContext) {
            locationHandler.startLocationServices()
        }
        
        if let trip = dataHandler.fetchActiveTrip(context: container.mainContext) {
            logger.debug("\(#function) : \(#line) : \(trip.debugDescription)")
        }

        return true
    }
    
    func scheduleUpdateLocationSettings() {
        let request = BGAppRefreshTaskRequest(identifier: "com.footprints.location")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60) // Fetch no earlier than 15 minutes from now
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            logger.error("Could not schedule app refresh: \(error.localizedDescription)")
        }
    }
    
    
    func handleUpdateLocationSettings(task: BGAppRefreshTask) {
        scheduleUpdateLocationSettings()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        let operation = CheckForActiveTripOperation(context: container.mainContext, locationHandler: locationHandler)
        
        task.expirationHandler = {
            // After all operations are cancelled, the completion block below is called to set the task to complete.
            queue.cancelAllOperations()
        }
        
        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
        }
        
        queue.addOperation(operation)
        
    }
}
#endif
