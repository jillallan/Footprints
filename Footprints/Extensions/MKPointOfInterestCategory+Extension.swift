//
//  MKPointOfInterestCategory+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 31/10/2024.
//

import Foundation
import MapKit

extension MKPointOfInterestCategory {
    func convertCategoryToLocationCategory() -> LocationCategory {
        let pointOfInterestString = self.rawValue.lowercased()
        let category = LocationCategory.allCases.first { locationCategory in
            pointOfInterestString.contains(locationCategory.rawValue.lowercased())
        }
        return category ?? .other
    }
}
