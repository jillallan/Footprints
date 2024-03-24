//
//  Navigation.swift
//  Footprints
//
//  Created by Jill Allan on 23/03/2024.
//

import Foundation
import SwiftUI

@Observable
class NavigationController {
    var navigationPath = NavigationPath()
}

extension NavigationController {
    static var preview: NavigationController = {
        NavigationController()
    }()
}
