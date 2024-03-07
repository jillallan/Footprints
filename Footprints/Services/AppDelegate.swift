//
//  AppDelegate.swift
//  Footprints
//
//  Created by Jill Allan on 31/01/2024.
//

#if os(iOS)
import BackgroundTasks
import Foundation
import UIKit
import SwiftData
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    @State var locationHandler: LocationHandler
    let container: ModelContainer

    override init() {
        
        
        let schema = Schema([Trip.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
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

        return true
    }
    
    func scheduleUpdateLocationSettings() {
        let request = BGAppRefreshTaskRequest(identifier: "com.footprints.location")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60) // Fetch no earlier than 15 minutes from now
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
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
