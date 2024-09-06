//
//  Constants.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import SwiftUI

struct Constants {
    static var cardSpacing: Double {
        #if os(tvOS)
        50
        #else
        20
        #endif
    }

    static let tripViewColumnCountCompact: Int = 1

    static let tripViewColumnCountCompactLandscape: Int = 2

    static var tripViewColumnCount: Int {
        #if os(iOS)
        3
        #else
        4
        #endif
    }

    static let cornerRadius: Double = 10.0

    static var outerPadding: Double {
        #if os(visionOS)
        50
        #elseif os(tvOS)
        0
        #else
        20
        #endif
    }
}
