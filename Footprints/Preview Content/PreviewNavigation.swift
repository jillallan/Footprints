//
//  PreviewNavigation.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import Foundation
import SwiftUI

struct PreviewNavigation: PreviewModifier {
    static func makeSharedContext() async throws -> NavigationController {
        let controller = NavigationController()
        return controller
    }
    
    func body(content: Content, context: NavigationController) -> some View {
        content.environmentObject(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var previewNavigation: Self = .modifier(PreviewNavigation())
}
