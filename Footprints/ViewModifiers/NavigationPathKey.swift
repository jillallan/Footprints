//
//  NavigationPathKey.swift
//  Footprints
//
//  Created by Jill Allan on 23/03/2024.
//

import Foundation
import SwiftUI

struct NavigationPathKey: PreferenceKey {
    static var defaultValue = NavigationPath()
    
    static func reduce(value: inout NavigationPath, nextValue: () -> NavigationPath) {
        value = nextValue()
    }
}

