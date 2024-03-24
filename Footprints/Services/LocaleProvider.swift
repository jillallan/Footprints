//
//  LocaleProvider.swift
//  Footprints
//
//  Created by Jill Allan on 23/03/2024.
//

import Foundation

struct LocaleProvider {
    
    static var regionsCoordinates: [RegionLocation] {
        Bundle.main.decode([RegionLocation].self, from: "region-coordinates.json")
    }
    
    /// Gets locale to use if location services are not enabled
    static func getLocale() -> String {
        
        // Get region identifier
        guard let region = Locale.current.region?.identifier else {
            return "United States"
        }
        
        // Convert region identifer to string
        let locale = Locale()
        guard let regionString = locale.localizedString(forRegionCode: region) else {
            return "United States"
        }
        return regionString
    }
}
