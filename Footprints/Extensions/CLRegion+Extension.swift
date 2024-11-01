//
//  CLCircularRegion+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import CoreLocation
import Foundation

extension CLRegion {
    static func getRadius(from region: CLRegion) -> Double? {
        let description = region.description
        
        // Define the regex pattern to capture the radius value after "radius"
        let pattern = "radius\\s(\\d+\\.?\\d*)"
        
        // Try to create a regular expression object
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            print("Invalid regex pattern")
            return nil
        }
        
        // Perform the regex search on the input description string
        let range = NSRange(location: 0, length: description.utf16.count)
        if let match = regex.firstMatch(in: description, options: [], range: range) {
            if let radiusRange = Range(match.range(at: 1), in: description) {
                let radiusString = String(description[radiusRange])
                return Double(radiusString) // Convert the radius string to a Double
            }
        }
        
        // Return nil if no match is found
        return nil
    }
    
    func getRadius() -> Double? {
        return Self.getRadius(from: self)
    }
}
