//
//  MapDetailStyle.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import Foundation
import SwiftUI

struct MapDetailPresentation: ViewModifier {
    func body(content: Content) -> some View {
        content
            .presentationDetents([.mapDetail])
            .presentationBackgroundInteraction(.enabled(upThrough: .mapDetail))
            .presentationDragIndicator(.visible)
    }
}
