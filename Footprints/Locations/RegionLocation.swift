//
//  RegionLocations.swift
//  Footprints
//
//  Created by Jill Allan on 23/03/2024.
//

import Foundation

struct RegionLocation: Decodable {
    let country: String
    let latitude: Double
    let longitude: Double
    let name: String
}
