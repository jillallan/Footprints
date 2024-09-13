//
//  PresentationDetent+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 13/09/2024.
//

import Foundation
import SwiftUI

extension PresentationDetent {
    static let bar = Self.custom(BarDetent.self)
}

private struct BarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(44, context.maxDetentValue * 0.1)
    }
}
