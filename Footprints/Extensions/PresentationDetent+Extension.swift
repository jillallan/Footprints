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
    static let small = Self.height(100)
    static let mapDetail = Self.height(300)
    static let extraLarge = Self.fraction(0.75)
}

private struct BarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(44, context.maxDetentValue * 0.1)
    }
}
