//
//  EnvironmentalValues.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write
    }
}
#endif
