//
//  CLPlacemark+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 22/01/2024.
//

import CoreLocation
import Foundation

extension CLPlacemark: PlacemarkDescribable {
    
    var areaOfInterest: String? {
        if let areasOfInterest {
            return areasOfInterest.first
        } else {
            return nil
        }
    }
}
