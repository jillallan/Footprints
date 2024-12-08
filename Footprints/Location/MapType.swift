//
//  MapType.swift
//  Footprints
//
//  Created by Jill Allan on 08/12/2024.
//

import Foundation

enum MapType: String, CaseIterable, Identifiable {
    case mapFeatures, anyLocation
    var id: Self { self }
}
