//
//  NavigationController.swift
//  Footprints
//
//  Created by Jill Allan on 03/09/2024.
//

import Foundation
import SwiftUI

class NavigationController: ObservableObject {
    @Published var navigationPath: NavigationPath

    init() {
        navigationPath = NavigationPath()
    }
}
