//
//  Item.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
