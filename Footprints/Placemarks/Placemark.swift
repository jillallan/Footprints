//
//  Placemark.swift
//  Footprints
//
//  Created by Jill Allan on 10/10/2024.
//

import Foundation
import SwiftData

@Model
final class Placemark {
    var name: String
    var country: String
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
}
